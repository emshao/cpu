module controlM(lastThree, multiplicand, newMultiplicand);

    input [2:0] lastThree;      // selector
    input [31:0] multiplicand;  // data_operandA
    
    output [32:0] newMultiplicand;

    // 000: do nothing 
    // 100: subtract 2*multiplicand 
    // 010: add multiplicand 
    // 110: subtract multiplicand
    // 001: add multiplicand
    // 101: subtract multiplicand
    // 011: add 2*multiplicand
    // 111: do nothing

    wire [32:0] M, M2, negM, negM2;
    wire [31:0] subMulti;
    wire carry;

    assign M = {multiplicand[31], multiplicand};
    assign M2 = {multiplicand, 1'b0};

    adder subM(.A(~multiplicand), .B(32'd1), .C0(1'b0), .sum(subMulti), .overflow(carry));
    assign negM = {subMulti[31], subMulti};
    assign negM2 = {negM, 1'b0};

    mux_8_33 newM(.out(newMultiplicand), .select(lastThree), .in0(33'd0), .in1(M), .in2(M), .in3(M2), .in4(negM2), .in5(negM), .in6(negM), .in7(33'd0));

endmodule