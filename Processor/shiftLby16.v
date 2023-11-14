module shiftLby16(A, out);

    input [31:0] A;
    output [31:0] out;

    assign out[15:0] = 16'b0000000000000000;
    assign out[31:16] = A[15:0];

    // assign out[0] = 1'b0;
    // assign out[1] = 1'b0;
    // assign out[2] = 1'b0;
    // assign out[3] = 1'b0;
    // assign out[4] = 1'b0;
    // assign out[5] = 1'b0;
    // assign out[6] = 1'b0;
    // assign out[7] = 1'b0;
    // assign out[8] = 1'b0;
    // assign out[9] = 1'b0;
    // assign out[10] = 1'b0;
    // assign out[11] = 1'b0;
    // assign out[12] = 1'b0;
    // assign out[13] = 1'b0;
    // assign out[14] = 1'b0;
    // assign out[15] = 1'b0;
    // assign out[16] = A[0];
    // assign out[17] = A[1];
    // assign out[18] = A[2];
    // assign out[19] = A[3];
    // assign out[20] = A[4];
    // assign out[21] = A[5];
    // assign out[22] = A[6];
    // assign out[23] = A[7];
    // assign out[24] = A[8];
    // assign out[25] = A[9];
    // assign out[26] = A[10];
    // assign out[27] = A[11];
    // assign out[28] = A[12];
    // assign out[29] = A[13];
    // assign out[30] = A[14];
    // assign out[31] = A[15];
    
endmodule