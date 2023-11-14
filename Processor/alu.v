module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow, multdivAns);
        
    input [31:0] data_operandA, data_operandB, multdivAns;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // created wires
    wire [31:0] flippedB, addSum, ss, andOut, orOut, SLLout, SRAout;
    wire addOverflow, subtractOverflow, isAdd, isEqualBit;
    wire [2:0] opcode;
    wire [1:0] lessThan_opcode;

    // addition
    adder add(.A(data_operandA), .B(data_operandB), .C0(1'b0), .sum(addSum), .overflow(addOverflow));

    // subtraction
    bitflip nott(.A(data_operandB), .out(flippedB));
    adder subtract(.A(data_operandA), .B(flippedB), .C0(1'b1), .sum(ss), .overflow(subtractOverflow));

    // and + or 
    andd andd(.A(data_operandA), .B(data_operandB), .out(andOut));
    orr orr(.A(data_operandA), .B(data_operandB), .out(orOut));

    // bit shifting
    SLL shiftLeft(.A(data_operandA), .shiftL(ctrl_shiftamt), .out(SLLout)); 
    SRA shiftRight(.A(data_operandA), .shift(ctrl_shiftamt), .out(SRAout));

    // isNotEqual
    or testingEqual(isNotEqual, ss[31], ss[30], ss[29], ss[28], ss[27], ss[26], ss[25], ss[24], ss[23], ss[22], ss[21], ss[20], ss[19], ss[18], ss[17], ss[16], ss[15], ss[14], ss[13], ss[12], ss[11], ss[10], ss[9], ss[8], ss[7], ss[6], ss[5], ss[4], ss[3], ss[2], ss[1], ss[0]);

    // isLessThan
    assign lessThan_opcode[1:0] = {data_operandA[31], data_operandB[31]};
    mux_4_1b determineLessThan(.out(isLessThan), .select(lessThan_opcode), .in0(ss[31]), .in1(1'b0), .in2(1'b1), .in3(ss[31]));

    // overflow
    or isAddOpcode(isAdd, ctrl_ALUopcode[4], ctrl_ALUopcode[3], ctrl_ALUopcode[2], ctrl_ALUopcode[1], ctrl_ALUopcode[0]);
    assign overflow = isAdd ? subtractOverflow : addOverflow; // 1 is subtract, 0 is add

    // determine which operation to choose
    assign opcode[2:0] = ctrl_ALUopcode[2:0];
    mux_8 chooseOperation(.out(data_result), .select(opcode), .in0(addSum), .in1(ss), .in2(andOut), .in3(orOut), .in4(SLLout), .in5(SRAout), .in6(multdivAns), .in7(multdivAns));

endmodule

