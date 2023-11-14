module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	// instantiated wires to store outputs

	wire [31:0] data_reg0, data_reg1, data_reg2, data_reg3, data_reg4, data_reg5, data_reg6, data_reg7, data_reg8, data_reg9;
	wire [31:0] data_reg10, data_reg11, data_reg12, data_reg13, data_reg14, data_reg15, data_reg16, data_reg17, data_reg18, data_reg19, data_reg20;
	wire [31:0] data_reg21, data_reg22, data_reg23, data_reg24, data_reg25, data_reg26, data_reg27, data_reg28, data_reg29, data_reg30, data_reg31;

	wire [31:0] writeHere, whichWrite, showA, showB;

	// logic to determine which one to write

	decoder #(32) writeTo(.out(whichWrite), .select(ctrl_writeReg), .enable(1'b1)); 
	and (writeHere[0], whichWrite[0], ctrl_writeEnable);
	and (writeHere[1], whichWrite[1], ctrl_writeEnable);
	and (writeHere[2], whichWrite[2], ctrl_writeEnable);
	and (writeHere[3], whichWrite[3], ctrl_writeEnable);
	and (writeHere[4], whichWrite[4], ctrl_writeEnable);
	and (writeHere[5], whichWrite[5], ctrl_writeEnable);
	and (writeHere[6], whichWrite[6], ctrl_writeEnable);
	and (writeHere[7], whichWrite[7], ctrl_writeEnable);
	and (writeHere[8], whichWrite[8], ctrl_writeEnable);
	and (writeHere[9], whichWrite[9], ctrl_writeEnable);
	and (writeHere[10], whichWrite[10], ctrl_writeEnable);
	and (writeHere[11], whichWrite[11], ctrl_writeEnable);
	and (writeHere[12], whichWrite[12], ctrl_writeEnable);
	and (writeHere[13], whichWrite[13], ctrl_writeEnable);
	and (writeHere[14], whichWrite[14], ctrl_writeEnable);
	and (writeHere[15], whichWrite[15], ctrl_writeEnable);
	and (writeHere[16], whichWrite[16], ctrl_writeEnable);
	and (writeHere[17], whichWrite[17], ctrl_writeEnable);
	and (writeHere[18], whichWrite[18], ctrl_writeEnable);
	and (writeHere[19], whichWrite[19], ctrl_writeEnable);
	and (writeHere[20], whichWrite[20], ctrl_writeEnable);
	and (writeHere[21], whichWrite[21], ctrl_writeEnable);
	and (writeHere[22], whichWrite[22], ctrl_writeEnable);
	and (writeHere[23], whichWrite[23], ctrl_writeEnable);
	and (writeHere[24], whichWrite[24], ctrl_writeEnable);
	and (writeHere[25], whichWrite[25], ctrl_writeEnable);
	and (writeHere[26], whichWrite[26], ctrl_writeEnable);
	and (writeHere[27], whichWrite[27], ctrl_writeEnable);
	and (writeHere[28], whichWrite[28], ctrl_writeEnable);
	and (writeHere[29], whichWrite[29], ctrl_writeEnable);
	and (writeHere[30], whichWrite[30], ctrl_writeEnable);
	and (writeHere[31], whichWrite[31], ctrl_writeEnable);

	
	// write to registers

	register reg0(.clk(clock), .in_en(writeHere[0]), .in_data(data_writeReg), .out_data(data_reg0), .reset(ctrl_reset));
	register reg1(.clk(clock), .in_en(writeHere[1]), .in_data(data_writeReg), .out_data(data_reg1), .reset(ctrl_reset));
	register reg2(.clk(clock), .in_en(writeHere[2]), .in_data(data_writeReg), .out_data(data_reg2), .reset(ctrl_reset));
	register reg3(.clk(clock), .in_en(writeHere[3]), .in_data(data_writeReg), .out_data(data_reg3), .reset(ctrl_reset));
	register reg4(.clk(clock), .in_en(writeHere[4]), .in_data(data_writeReg), .out_data(data_reg4), .reset(ctrl_reset));
	register reg5(.clk(clock), .in_en(writeHere[5]), .in_data(data_writeReg), .out_data(data_reg5), .reset(ctrl_reset));
	register reg6(.clk(clock), .in_en(writeHere[6]), .in_data(data_writeReg), .out_data(data_reg6), .reset(ctrl_reset));
	register reg7(.clk(clock), .in_en(writeHere[7]), .in_data(data_writeReg), .out_data(data_reg7), .reset(ctrl_reset));
	register reg8(.clk(clock), .in_en(writeHere[8]), .in_data(data_writeReg), .out_data(data_reg8), .reset(ctrl_reset));
	register reg9(.clk(clock), .in_en(writeHere[9]), .in_data(data_writeReg), .out_data(data_reg9), .reset(ctrl_reset));
	register reg10(.clk(clock), .in_en(writeHere[10]), .in_data(data_writeReg), .out_data(data_reg10), .reset(ctrl_reset));
	register reg11(.clk(clock), .in_en(writeHere[11]), .in_data(data_writeReg), .out_data(data_reg11), .reset(ctrl_reset));
	register reg12(.clk(clock), .in_en(writeHere[12]), .in_data(data_writeReg), .out_data(data_reg12), .reset(ctrl_reset));
	register reg13(.clk(clock), .in_en(writeHere[13]), .in_data(data_writeReg), .out_data(data_reg13), .reset(ctrl_reset));
	register reg14(.clk(clock), .in_en(writeHere[14]), .in_data(data_writeReg), .out_data(data_reg14), .reset(ctrl_reset));
	register reg15(.clk(clock), .in_en(writeHere[15]), .in_data(data_writeReg), .out_data(data_reg15), .reset(ctrl_reset));
	register reg16(.clk(clock), .in_en(writeHere[16]), .in_data(data_writeReg), .out_data(data_reg16), .reset(ctrl_reset));
	register reg17(.clk(clock), .in_en(writeHere[17]), .in_data(data_writeReg), .out_data(data_reg17), .reset(ctrl_reset));
	register reg18(.clk(clock), .in_en(writeHere[18]), .in_data(data_writeReg), .out_data(data_reg18), .reset(ctrl_reset));
	register reg19(.clk(clock), .in_en(writeHere[19]), .in_data(data_writeReg), .out_data(data_reg19), .reset(ctrl_reset));
	register reg20(.clk(clock), .in_en(writeHere[20]), .in_data(data_writeReg), .out_data(data_reg20), .reset(ctrl_reset));
	register reg21(.clk(clock), .in_en(writeHere[21]), .in_data(data_writeReg), .out_data(data_reg21), .reset(ctrl_reset));
	register reg22(.clk(clock), .in_en(writeHere[22]), .in_data(data_writeReg), .out_data(data_reg22), .reset(ctrl_reset));
	register reg23(.clk(clock), .in_en(writeHere[23]), .in_data(data_writeReg), .out_data(data_reg23), .reset(ctrl_reset));
	register reg24(.clk(clock), .in_en(writeHere[24]), .in_data(data_writeReg), .out_data(data_reg24), .reset(ctrl_reset));
	register reg25(.clk(clock), .in_en(writeHere[25]), .in_data(data_writeReg), .out_data(data_reg25), .reset(ctrl_reset));
	register reg26(.clk(clock), .in_en(writeHere[26]), .in_data(data_writeReg), .out_data(data_reg26), .reset(ctrl_reset));
	register reg27(.clk(clock), .in_en(writeHere[27]), .in_data(data_writeReg), .out_data(data_reg27), .reset(ctrl_reset));
	register reg28(.clk(clock), .in_en(writeHere[28]), .in_data(data_writeReg), .out_data(data_reg28), .reset(ctrl_reset));
	register reg29(.clk(clock), .in_en(writeHere[29]), .in_data(data_writeReg), .out_data(data_reg29), .reset(ctrl_reset));
	register reg30(.clk(clock), .in_en(writeHere[30]), .in_data(data_writeReg), .out_data(data_reg30), .reset(ctrl_reset));
	register reg31(.clk(clock), .in_en(writeHere[31]), .in_data(data_writeReg), .out_data(data_reg31), .reset(ctrl_reset));


	// logic to choose which register to read for A and B

	decoder #(32) findA(.out(showA), .select(ctrl_readRegA), .enable(1'b1)); 
	decoder #(32) findB(.out(showB), .select(ctrl_readRegB), .enable(1'b1)); 


	// using tri-states to assign the data to the output

	assign data_readRegA = showA[0] ? data_reg0 : 32'bz;
	assign data_readRegA = showA[1] ? data_reg1 : 32'bz;
	assign data_readRegA = showA[2] ? data_reg2 : 32'bz;
	assign data_readRegA = showA[3] ? data_reg3 : 32'bz;
	assign data_readRegA = showA[4] ? data_reg4 : 32'bz;
	assign data_readRegA = showA[5] ? data_reg5 : 32'bz;
	assign data_readRegA = showA[6] ? data_reg6 : 32'bz;
	assign data_readRegA = showA[7] ? data_reg7 : 32'bz;
	assign data_readRegA = showA[8] ? data_reg8 : 32'bz;
	assign data_readRegA = showA[9] ? data_reg9 : 32'bz;
	assign data_readRegA = showA[10] ? data_reg10 : 32'bz;
	assign data_readRegA = showA[11] ? data_reg11 : 32'bz;
	assign data_readRegA = showA[12] ? data_reg12 : 32'bz;
	assign data_readRegA = showA[13] ? data_reg13 : 32'bz;
	assign data_readRegA = showA[14] ? data_reg14 : 32'bz;
	assign data_readRegA = showA[15] ? data_reg15 : 32'bz;
	assign data_readRegA = showA[16] ? data_reg16 : 32'bz;
	assign data_readRegA = showA[17] ? data_reg17 : 32'bz;
	assign data_readRegA = showA[18] ? data_reg18 : 32'bz;
	assign data_readRegA = showA[19] ? data_reg19 : 32'bz;
	assign data_readRegA = showA[20] ? data_reg20 : 32'bz;
	assign data_readRegA = showA[21] ? data_reg21 : 32'bz;
	assign data_readRegA = showA[22] ? data_reg22 : 32'bz;
	assign data_readRegA = showA[23] ? data_reg23 : 32'bz;
	assign data_readRegA = showA[24] ? data_reg24 : 32'bz;
	assign data_readRegA = showA[25] ? data_reg25 : 32'bz;
	assign data_readRegA = showA[26] ? data_reg26 : 32'bz;
	assign data_readRegA = showA[27] ? data_reg27 : 32'bz;
	assign data_readRegA = showA[28] ? data_reg28 : 32'bz;
	assign data_readRegA = showA[29] ? data_reg29 : 32'bz;
	assign data_readRegA = showA[30] ? data_reg30 : 32'bz;
	assign data_readRegA = showA[31] ? data_reg31 : 32'bz;

	assign data_readRegB = showB[0] ? data_reg0 : 32'bz;
	assign data_readRegB = showB[1] ? data_reg1 : 32'bz;
	assign data_readRegB = showB[2] ? data_reg2 : 32'bz;
	assign data_readRegB = showB[3] ? data_reg3 : 32'bz;
	assign data_readRegB = showB[4] ? data_reg4 : 32'bz;
	assign data_readRegB = showB[5] ? data_reg5 : 32'bz;
	assign data_readRegB = showB[6] ? data_reg6 : 32'bz;
	assign data_readRegB = showB[7] ? data_reg7 : 32'bz;
	assign data_readRegB = showB[8] ? data_reg8 : 32'bz;
	assign data_readRegB = showB[9] ? data_reg9 : 32'bz;
	assign data_readRegB = showB[10] ? data_reg10 : 32'bz;
	assign data_readRegB = showB[11] ? data_reg11 : 32'bz;
	assign data_readRegB = showB[12] ? data_reg12 : 32'bz;
	assign data_readRegB = showB[13] ? data_reg13 : 32'bz;
	assign data_readRegB = showB[14] ? data_reg14 : 32'bz;
	assign data_readRegB = showB[15] ? data_reg15 : 32'bz;
	assign data_readRegB = showB[16] ? data_reg16 : 32'bz;
	assign data_readRegB = showB[17] ? data_reg17 : 32'bz;
	assign data_readRegB = showB[18] ? data_reg18 : 32'bz;
	assign data_readRegB = showB[19] ? data_reg19 : 32'bz;
	assign data_readRegB = showB[20] ? data_reg20 : 32'bz;
	assign data_readRegB = showB[21] ? data_reg21 : 32'bz;
	assign data_readRegB = showB[22] ? data_reg22 : 32'bz;
	assign data_readRegB = showB[23] ? data_reg23 : 32'bz;
	assign data_readRegB = showB[24] ? data_reg24 : 32'bz;
	assign data_readRegB = showB[25] ? data_reg25 : 32'bz;
	assign data_readRegB = showB[26] ? data_reg26 : 32'bz;
	assign data_readRegB = showB[27] ? data_reg27 : 32'bz;
	assign data_readRegB = showB[28] ? data_reg28 : 32'bz;
	assign data_readRegB = showB[29] ? data_reg29 : 32'bz;
	assign data_readRegB = showB[30] ? data_reg30 : 32'bz;
	assign data_readRegB = showB[31] ? data_reg31 : 32'bz;

endmodule
