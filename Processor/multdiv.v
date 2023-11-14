module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] insideA, insideB;

    
    gRegister #(32) holdDataA(.clk(clock), .in_en(ctrl_MULT | ctrl_DIV), .in_data(data_operandA), .out_data(insideA), .reset(1'b0));
    gRegister #(32) holdDataB(.clk(clock), .in_en(ctrl_MULT | ctrl_DIV), .in_data(data_operandB), .out_data(insideB), .reset(1'b0));


    // add your code here -- declare wire
    wire [65:0] intoReg, outReg, intoDiv, outDiv;
    wire [65:0] initializeB, initialDiv, tempWire, loopWire;
    wire [32:0] toAddIn, topHalf;
    wire [31:0] useThisA, useThisB, toSubIn, negA, negB, negQ, quotient;
    wire carry, allOnes, allZeros, signCase, same, divZero, rst, op, enable, data_exception_mult, at16, at32, putSign;

    // latch operation
    or whenLatch(enable, ctrl_MULT, ctrl_DIV);
    dffe_ref operation(.q(op), .d(ctrl_MULT), .clk(clock), .en(enable), .clr(ctrl_DIV)); // 0 = division

    // set up my register as the thing that will hold my data
    register66 registMult(.clk(clock), .in_en(1'b1), .in_data(intoReg), .out_data(outReg), .reset(1'b0));
    register66 registDiv(.clk(clock), .in_en(1'b1), .in_data(intoDiv), .out_data(outDiv), .reset(1'b0));

    // put insideB into the MULT register on first clock cycle
    assign initializeB = {33'b0, insideB, 1'b0};
    assign intoReg = ctrl_MULT ? initializeB : tempWire;

    // put insideA into the DIV register on first clock cycle
    adder makeNegA(.A(~insideA), .B(32'd1), .C0(1'b0), .sum(negA), .overflow());
    adder makeNegB(.A(~insideB), .B(32'd1), .C0(1'b0), .sum(negB), .overflow());
    assign useThisA = insideA[31] ? negA : insideA;
    assign useThisB = insideB[31] ? negB : insideB;

    assign initialDiv = {34'b0, useThisA};
    assign intoDiv = ctrl_DIV ? initialDiv : loopWire;

    // figure out what needs to be added to the top half
    controlM chooseAdd(.lastThree(outReg[2:0]), .multiplicand(insideA), .newMultiplicand(toAddIn));
    controlD chooseSub(.firstBit(outDiv[63]), .divisor(useThisB), .toSubtract(toSubIn));

    // for multiply --- add it, and also calculate the bonus bit
    adder add(.A(outReg[64:33]), .B(toAddIn[31:0]), .C0(1'b0), .sum(topHalf[31:0]), .overflow(carry));
    xor highBit(topHalf[32], outReg[65], toAddIn[32], carry);
    // shift the output by two
    assign tempWire = {topHalf[32], topHalf[32], topHalf[32:0], outReg[32:2]};

    // for division --- shift first, then add or subtract the divisor 
    adder sub(.A(outDiv[62:31]), .B(toSubIn), .C0(1'b0), .sum(loopWire[63:32]), .overflow());
    assign loopWire[31:0] = {outDiv[30:0], !loopWire[63]};

    // read final result
    adder makeNegQ(.A(~outDiv[31:0]), .B(32'd1), .C0(1'b0), .sum(negQ), .overflow());
    xor checkSign(putSign, insideA[31], insideB[31]);
    assign quotient = putSign ? negQ : outDiv[31:0];
    assign data_result = op ? outReg[32:1] : quotient;
    
    // read only when data_resultready is high, but feed directly into output
    or resetNow(rst, ctrl_DIV, ctrl_MULT);
    counter count32(.clock(clock), .highBit16(at16), .highBit32(at32), .reset(rst));
    assign data_resultRDY = op ? at16 : at32;

    // data_exception raises when there is multiplication overflow
    assign allOnes = !(&outReg[64:32]);
    assign allZeros = |outReg[64:32];
    assign signCase = (insideA[31] & insideB[31] & data_result[31]) | (!insideA[31] & !insideB[31] & data_result[31]);
    and dataE(same, allOnes, allZeros);
    or dataExcep(data_exception_mult, same, signCase);

    // data_exception raises when divide by 0
    assign data_exception = op ? data_exception_mult : !(|insideB);

endmodule