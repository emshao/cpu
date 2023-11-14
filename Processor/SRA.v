module SRA(A, shift, out);

    input [31:0] A;
    output [31:0] out;
    input [4:0] shift;

    wire [31:0] one, two, four, eight, sixteen;
    wire [31:0] level1, level2, level3, level4;

    shiftRby16 by16R(.A(A), .out(sixteen));
    assign level1 = shift[4] ? sixteen : A;
    
    shiftRby8 by8R(.A(level1), .out(eight));
    assign level2 = shift[3] ? eight : level1;
    
    shiftRby4 by4R(.A(level2), .out(four));
    assign level3 = shift[2] ? four : level2;

    shiftRby2 by2R(.A(level3), .out(two));
    assign level4 = shift[1] ? two : level3;

    shiftRby1 by1R(.A(level4), .out(one));
    assign out = shift[0] ? one : level4;

endmodule