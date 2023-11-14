module tff(T, clock, Q, reset);

    input T, clock, reset;
    output Q;

    wire notT, topAnd, bottomAnd, midOr, notQ;

    assign notT = ~T;
    assign notQ = ~Q;

    and top(topAnd, notT, Q);
    and bottom(bottomAnd, T, notQ);

    or middle(midOr, topAnd, bottomAnd);

    dffe_ref dff(.q(Q), .d(midOr), .clk(clock), .en(1'b1), .clr(reset));

endmodule