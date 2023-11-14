module CLA8(A, B, C0, S, G, P);

    input [7:0] A, B;
    input C0;
    output [7:0] S;
    output G, P;

    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire p0, p1, p2, p3, p4, p5, p6, p7;
    wire c1, c2, c3, c4, c5, c6, c7;

    and and0(g0, A[0], B[0]);
    and and1(g1, A[1], B[1]);
    and and2(g2, A[2], B[2]);
    and and3(g3, A[3], B[3]);
    and and4(g4, A[4], B[4]);
    and and5(g5, A[5], B[5]);
    and and6(g6, A[6], B[6]);
    and and7(g7, A[7], B[7]);

    or or0(p0, A[0], B[0]);
    or or1(p1, A[1], B[1]);
    or or2(p2, A[2], B[2]);
    or or3(p3, A[3], B[3]);
    or or4(p4, A[4], B[4]);
    or or5(p5, A[5], B[5]);
    or or6(p6, A[6], B[6]);
    or or7(p7, A[7], B[7]);

    wire c1and1;
    and c1_and1(c1and1, p0, C0);
    or end_c1(c1, g0, c1and1);

    wire c2and1, c2and2;
    and c2_and1(c2and1, p1, p0, C0);
    and c2_and2(c2and2, p1, g0);
    or end_c2(c2, g1, c2and1, c2and2);

    wire c3and1, c3and2, c3and3;
    and c3_and1(c3and1, p2, p1, p0, C0);
    and c3_and2(c3and2, p2, p1, g0);
    and c3_and3(c3and3, p2, g1);
    or end_c3(c3, g2, c3and1, c3and2, c3and3);

    wire c4and1, c4and2, c4and3, c4and4;
    and c4_and1(c4and1, p3, p2, p1, p0, C0);
    and c4_and2(c4and2, p3, p2, p1, g0);
    and c4_and3(c4and3, p3, p2, g1);
    and c4_and4(c4and4, p3, g2);
    or end_c4(c4, g3, c4and1, c4and2, c4and3, c4and4);

    wire c5and1, c5and2, c5and3, c5and4, c5and5;
    and c5_and1(c5and1, p4, p3, p2, p1, p0, C0);
    and c5_and2(c5and2, p4, p3, p2, p1, g0);
    and c5_and3(c5and3, p4, p3, p2, g1);
    and c5_and4(c5and4, p4, p3, g2);
    and c5_and5(c5and5, p4, g3);
    or end_c5(c5, g4, c5and1, c5and2, c5and3, c5and4, c5and5);

    wire c6and1, c6and2, c6and3, c6and4, c6and5, c6and6;
    and c6_and1(c6and1, p5, p4, p3, p2, p1, p0, C0);
    and c6_and2(c6and2, p5, p4, p3, p2, p1, g0);
    and c6_and3(c6and3, p5, p4, p3, p2, g1);
    and c6_and4(c6and4, p5, p4, p3, g2);
    and c6_and5(c6and5, p5, p4, g3);
    and c6_and6(c6and6, p5, g4);
    or end_c6(c6, g5, c6and1, c6and2, c6and3, c6and4, c6and5, c6and6);
    
    wire c7and1, c7and2, c7and3, c7and4, c7and5, c7and6, c7and7;
    and c7_and1(c7and1, p6, p5, p4, p3, p2, p1, p0, C0);
    and c7_and2(c7and2, p6, p5, p4, p3, p2, p1, g0);
    and c7_and3(c7and3, p6, p5, p4, p3, p2, g1);
    and c7_and4(c7and4, p6, p5, p4, p3, g2);
    and c7_and5(c7and5, p6, p5, p4, g3);
    and c7_and6(c7and6, p6, p5, g4);
    and c7_and7(c7and7, p6, g5);
    or end_c7(c7, g6, c7and1, c7and2, c7and3, c7and4, c7and5, c7and6, c7and7);

    xor sum0(S[0], A[0], B[0], C0);
    xor sum1(S[1], A[1], B[1], c1);
    xor sum2(S[2], A[2], B[2], c2);
    xor sum3(S[3], A[3], B[3], c3);
    xor sum4(S[4], A[4], B[4], c4);
    xor sum5(S[5], A[5], B[5], c5);
    xor sum6(S[6], A[6], B[6], c6);
    xor sum7(S[7], A[7], B[7], c7);

    wire c8and1, c8and2, c8and3, c8and4, c8and5, c8and6, c8and7, c8and8;
    and getP(P, p7, p6, p5, p4, p3, p2, p1, p0);
    and c8_and2(c8and2, p7, p6, p5, p4, p3, p2, p1, g0);
    and c8_and3(c8and3, p7, p6, p5, p4, p3, p2, g1);
    and c8_and4(c8and4, p7, p6, p5, p4, p3, g2);
    and c8_and5(c8and5, p7, p6, p5, p4, g3);
    and c8_and6(c8and6, p7, p6, p5, g4);
    and c8_and7(c8and7, p7, p6, g5);
    and c8_and8(c8and8, p7, g6);
    or outG(G, g7, c8and2, c8and3, c8and4, c8and5, c8and6, c8and7, c8and8);
    
endmodule