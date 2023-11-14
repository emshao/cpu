module counter(clock, highBit16, highBit32, reset);

    input clock, reset;
    output highBit16, highBit32;

    // build five bit counter, when the most significant bit is 1, then it's 16
    wire t1, t2, t3, t4, t5;
    wire q0, q1, q2, q3;

    and and0(t1, 1'b1, q0);
    and and1(t2, t1, q1);
    and and2(t3, t2, q2);
    and and3(t4, t3, q3);
    and and4(t5, t4, highBit16);

    tff bit0(.T(1'b1), .clock(clock), .Q(q0), .reset(reset));
    tff bit1(.T(t1), .clock(clock), .Q(q1), .reset(reset));
    tff bit2(.T(t2), .clock(clock), .Q(q2), .reset(reset));
    tff bit3(.T(t3), .clock(clock), .Q(q3), .reset(reset));
    tff bit4(.T(t4), .clock(clock), .Q(highBit16), .reset(reset));
    tff bit5(.T(t5), .clock(clock), .Q(highBit32), .reset(reset));

endmodule