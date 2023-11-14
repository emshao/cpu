module shiftRby1(A, out);

    input [31:0] A;
    output [31:0] out;

    assign out[31] = A[31];
    assign out[30:0] = A[31:1];

endmodule