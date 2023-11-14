module adder(A, B, C0, sum, overflow);

    input [31:0] A, B;
    input C0;

    output [31:0] sum;
    output overflow;

    wire G0, P0, G1, P1, G2, P2, G3, P3;
    wire c8, PC0, c16, PC1_1, PC1_2, c24, PC2_1, PC2_2, PC2_3, c32, PC3_1, PC3_2, PC3_3, PC3_4;
    wire diff, hasOF;
    

    // first 8 bits
    CLA8 first8(.A(A[7:0]), .B(B[7:0]), .C0(C0), .S(sum[7:0]), .G(G0), .P(P0));

    and and1(PC0, C0, P0);
    or calc_c8(c8, G0, PC0);


    // second 8 bits 
    CLA8 second8(.A(A[15:8]), .B(B[15:8]), .C0(c8), .S(sum[15:8]), .G(G1), .P(P1));

    and and2_1(PC1_1, P1, P0, C0);
    and and2_2(PC1_2, P1, G0);
    or calc_c16(c16, G1, PC1_1, PC1_2);


    // third 8 bits
    CLA8 third8(.A(A[23:16]), .B(B[23:16]), .C0(c16), .S(sum[23:16]), .G(G2), .P(P2));

    and and3_1(PC2_1, P2, P1, P0, C0);
    and and3_2(PC2_2, P2, P1, G0);
    and and3_3(PC2_3, P2, G1);
    or calc_c24(c24, G2, PC2_1, PC2_2, PC2_3);


    // fourth 8 bits
    CLA8 fourth8(.A(A[31:24]), .B(B[31:24]), .C0(c24), .S(sum[31:24]), .G(G3), .P(P3));


    // determine overflow
    xor checkOvf(diff, A[31], B[31]); // will be 1 if differs, 0 if matches
    xor hasOvf(hasOF, B[31], sum[31]);
    assign overflow = diff ? 1'b0 : hasOF;

endmodule