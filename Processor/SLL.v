module SLL(A, shiftL, out);

    input [31:0] A;
    output [31:0] out;
    input [4:0] shiftL;

    wire [31:0] oneL, twoL, fourL, eightL, sixteenL;
    wire [31:0] level1L, level2L, level3L, level4L;

    shiftLby16 by16L(.A(A), .out(sixteenL));
    assign level1L = shiftL[4] ? sixteenL : A;
    
    shiftLby8 by8L(.A(level1L), .out(eightL));
    assign level2L = shiftL[3] ? eightL : level1L;
    
    shiftLby4 by4L(.A(level2L), .out(fourL));
    assign level3L = shiftL[2] ? fourL : level2L;

    shiftLby2 by2L(.A(level3L), .out(twoL));
    assign level4L = shiftL[1] ? twoL : level3L;

    shiftLby1 by1L(.A(level4L), .out(oneL));
    assign out = shiftL[0] ? oneL : level4L;

endmodule