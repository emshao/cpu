module gRegister #(parameter SIZE = 32) (clk, in_en, in_data, out_data, reset);

    input clk, in_en, reset;
    input [SIZE-1:0] in_data;
    output [SIZE-1:0] out_data;

    genvar i;

    generate
        for (i=0; i<=SIZE-1; i=i+1)
        begin
            dffe_ref dff (.q(out_data[i]), .d(in_data[i]), .clk(clk), .en(in_en), .clr(reset));
        end
    endgenerate

endmodule
