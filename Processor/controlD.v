module controlD(firstBit, divisor, toSubtract);
    input firstBit;
    input [31:0] divisor;
    output [31:0] toSubtract;

    wire [31:0] negDivisor;
    wire carry;

    adder subD(.A(~divisor), .B(32'd1), .C0(1'b0), .sum(negDivisor), .overflow(carry));

    assign toSubtract = firstBit ? divisor : negDivisor;

endmodule