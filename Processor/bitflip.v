module bitflip(A, out);

    input [31:0] A;
    output [31:0] out;

    not n0(out[0], A[0]);
    not n1(out[1], A[1]);
    not n2(out[2], A[2]);
    not n3(out[3], A[3]);
    not n4(out[4], A[4]);
    not n5(out[5], A[5]);
    not n6(out[6], A[6]);
    not n7(out[7], A[7]);
    not n8(out[8], A[8]);
    not n9(out[9], A[9]);
    not n10(out[10], A[10]);
    not n11(out[11], A[11]);
    not n12(out[12], A[12]);
    not n13(out[13], A[13]);
    not n14(out[14], A[14]);
    not n15(out[15], A[15]);
    not n16(out[16], A[16]);
    not n17(out[17], A[17]);
    not n18(out[18], A[18]);
    not n19(out[19], A[19]);
    not n20(out[20], A[20]);
    not n21(out[21], A[21]);
    not n22(out[22], A[22]);
    not n23(out[23], A[23]);
    not n24(out[24], A[24]);
    not n25(out[25], A[25]);
    not n26(out[26], A[26]);
    not n27(out[27], A[27]);
    not n28(out[28], A[28]);
    not n29(out[29], A[29]);
    not n30(out[30], A[30]);
    not n31(out[31], A[31]);

endmodule