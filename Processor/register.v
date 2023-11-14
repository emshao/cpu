module register (clk, in_en, in_data, out_data, reset);

    input clk, in_en, reset;
    input [31:0] in_data;
    output [31:0] out_data;

    wire yesWrite;

    and whenToWrite(yesWrite, 1'b1, in_en);

    // should be in loop
    dffe_ref dff0(.q(out_data[0]), .d(in_data[0]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff1(.q(out_data[1]), .d(in_data[1]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff2(.q(out_data[2]), .d(in_data[2]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff3(.q(out_data[3]), .d(in_data[3]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff4(.q(out_data[4]), .d(in_data[4]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff5(.q(out_data[5]), .d(in_data[5]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff6(.q(out_data[6]), .d(in_data[6]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff7(.q(out_data[7]), .d(in_data[7]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff8(.q(out_data[8]), .d(in_data[8]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff9(.q(out_data[9]), .d(in_data[9]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff10(.q(out_data[10]), .d(in_data[10]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff11(.q(out_data[11]), .d(in_data[11]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff12(.q(out_data[12]), .d(in_data[12]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff13(.q(out_data[13]), .d(in_data[13]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff14(.q(out_data[14]), .d(in_data[14]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff15(.q(out_data[15]), .d(in_data[15]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff16(.q(out_data[16]), .d(in_data[16]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff17(.q(out_data[17]), .d(in_data[17]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff18(.q(out_data[18]), .d(in_data[18]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff19(.q(out_data[19]), .d(in_data[19]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff20(.q(out_data[20]), .d(in_data[20]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff21(.q(out_data[21]), .d(in_data[21]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff22(.q(out_data[22]), .d(in_data[22]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff23(.q(out_data[23]), .d(in_data[23]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff24(.q(out_data[24]), .d(in_data[24]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff25(.q(out_data[25]), .d(in_data[25]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff26(.q(out_data[26]), .d(in_data[26]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff27(.q(out_data[27]), .d(in_data[27]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff28(.q(out_data[28]), .d(in_data[28]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff29(.q(out_data[29]), .d(in_data[29]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff30(.q(out_data[30]), .d(in_data[30]), .clk(clk), .en(yesWrite), .clr(reset));
    dffe_ref dff31(.q(out_data[31]), .d(in_data[31]), .clk(clk), .en(yesWrite), .clr(reset));



endmodule