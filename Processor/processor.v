/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem - instruction memory
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem - data memory
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem; // next instruction
	input [31:0] q_imem; // data from instruction, assume to be filled in immediately

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	
    
    /* YOUR CODE STARTS HERE */

    

    /************************************************ Variables by Stage ***********************************************/
    /******** FETCH ********/
    /******** DECODE ********/
    /******** EXECUTE ********/
    /******** MULTDIV ********/
    /******** MEMORY ********/
    /******** WRITE ********/











    wire stalling;
    wire branching;

    wire isJR_x;
    wire [31:0] intoPC, curPC, PCplus1, PC_latchFD, PC_latchDX, PC_latchXM, PC_latchMW;
    wire [31:0] PC_Fetch, PC_Decode, PC_Execute, pc_next, pc_branch;













    // FETCH STAGE!
    // fetch stage -- assign PC at the end

    gRegister #(32) PC_F (.clk(~clock), .in_en(~stalling), .in_data(intoPC), .out_data(curPC), .reset(reset)); // storing current PC

    assign address_imem = (isBEX_x | isBNE_x | isBLT_x) ? 0 : curPC; // assume you automatically get q_imem


    adder PCadd1(.A(curPC), .B(0), .C0(1'b1), .sum(PCplus1), .overflow());

    assign PC_Fetch = (q_imem[31:27] == 5'b00001 | q_imem[31:27] == 5'b00011) ? {5'b0, q_imem[26:0]} : PCplus1; // just for Jump


    // wire [31:0] PC_forJR = isJR_x ? 0 : PC_Fetch;
    
    wire [31:0] pc_bne_change = (isBNE_x | isBLT_x) ? PC_bne : PC_Fetch;
    wire [31:0] pc_bex_change = isBEX_x ? PC_bex : pc_bne_change;
    assign pc_next = isJR_d ? intoDataB : pc_bex_change;

    assign intoPC = reset ? 32'b0 : pc_next; // change for jumps


    wire [31:0] PCplus1_d, PCplus1_x, PCplus1_m, PCplus1_w;


    // FD latches -- store PCnext and instruction
    wire [31:0] instInDecode;
    gRegister #(32) PC_FDlatch (.clk(~clock), .in_en(~stalling), .in_data(PC_Fetch), .out_data(PC_latchFD), .reset(reset)); // why do I need to save this throughout all 5?
    gRegister #(32) IN_FDlatch (.clk(~clock), .in_en(~stalling), .in_data(q_imem), .out_data(instInDecode), .reset(reset));
    gRegister #(32) pc1_f (.clk(~clock), .in_en(~stalling), .in_data(PCplus1), .out_data(PCplus1_d), .reset(reset));
    

    // check if should flush or stall logic here

    wire [31:0] instInFD = (instInDecode[31:27] == 5'b10101) ? {15'b001011111000000, instInDecode[16:0]} : instInDecode;



    wire [4:0] opcode_d, rd_d, rs_d, rt_d;


    // decode stage 
    assign {opcode_d, rd_d, rs_d, rt_d} = instInFD[31:12];

    wire isBNE_d, isBLT_d, isJAL_d, isBEX_d, isSW_d, isJR_d;

    assign isBNE_d = (opcode_d == 5'b00010);
    assign isJAL_d = (opcode_d == 5'b00011);
    assign isJR_d = (opcode_d == 5'b00100);
    assign isBEX_d = (opcode_d == 5'b10110);

    assign isSW_d = (opcode_d == 5'b00111);
    assign isBLT_d = (opcode_d == 5'b00110);

    assign ctrl_readRegA = isBEX_d ? 30 : rs_d;
    assign ctrl_readRegB = (isJR_d | isSW_d | isBNE_d | isBLT_d) ? rd_d : rt_d;                  // immediately has dataB
    

    /*********************************Push nop through*******************************/
    wire [31:0] instInD = (isJR_x | isBEX_x | isBLT_x | isBNE_x) ? 0 : instInFD;







    wire [31:0] dataA_x, dataB_x, instInExecute;

    // DX latches
    gRegister #(32) PC_DXlatch (.clk(~clock), .in_en(~stalling), .in_data(PC_latchFD), .out_data(PC_latchDX), .reset(reset));
    gRegister #(32) IN_DXlatch (.clk(~clock), .in_en(~stalling), .in_data(instInD), .out_data(instInExecute), .reset(reset));

    gRegister #(32) DXRegA (.clk(~clock), .in_en(1'b1), .in_data(data_readRegA), .out_data(dataA_x), .reset(reset));
    gRegister #(32) DXRegB (.clk(~clock), .in_en(1'b1), .in_data(data_readRegB), .out_data(dataB_x), .reset(reset));

    
    gRegister #(32) pc1_d (.clk(~clock), .in_en(~stalling), .in_data(PCplus1_d), .out_data(PCplus1_x), .reset(reset));

    // execute stage

    wire isBNE_x, isBLT_x, isJAL_x, isSW_x, isLW_x, isADDI_x, isALU_x;

    wire [31:0] mdOUT, aluOUT, addiOUT;
    wire mdExcept, mdReady;
    wire aluNE, aluLT, aluOVF;

    wire [4:0] opcode_x, rd_x, rs_x, rt_x;
    assign {opcode_x, rd_x, rs_x, rt_x} = instInExecute[31:12];

    wire isBEX_x = ((opcode_x==5'b10110) & (dataA_x != 32'b0)) | ((opcode_x==5'b10110) & (rd_m==5'b11110) & (dataFromALU_m != 32'b0)) | ((opcode_x==5'b10110) & (rd_w==5'b11110));
    assign isBNE_x = (opcode_x == 5'b00010) & aluNE;
    assign isBLT_x = (opcode_x == 5'b00110) & (~aluOUT[31] & |(aluOUT));


    wire [31:0] PCplus1plusN;
    adder findPC1N(.A(PC_latchDX), .B(immediate_x), .C0(1'b0), .sum(PCplus1plusN), .overflow());

    wire [31:0] PC_bex = isBEX_x ? {5'b0, instInExecute[26:0]} : PC_latchDX;
    wire [31:0] PC_bne = (isBNE_x | isBLT_x) ? PCplus1plusN : PC_latchDX;

    assign isSW_x = (opcode_x == 5'b00111);
    assign isLW_x = (opcode_x == 5'b01000);
    assign isADDI_x = (opcode_x == 5'b00101);
    assign isALU_x = (opcode_x == 5'b00000);

    assign isJAL_x = (opcode_x == 5'b00011);
    assign isJR_x = (opcode_x == 5'b00100);

    wire [4:0] subtract = (opcode_x == 5'b00110) ? 5'b00001 : instInExecute[6:2];      // check if subtraction needed
    wire addImmediate = (isADDI_x | isSW_x | isLW_x);
    wire [4:0] ALUop_x = addImmediate ? 5'b00000 : subtract; // check if adding immediate needed


    wire [4:0] shiftamt_x = instInExecute[11:7];
    wire [31:0] immediate_x = {{15{instInExecute[16]}}, instInExecute[16:0]};


    wire [31:0] dataForWriteReg;
    wire [4:0] opcode_m;

    // // bypass
    wire [31:0] prevBypassA = ((rd_w != 5'b00000) & (rd_w == rs_x) & (opcode_x != 5'b00111)) ? data_writeReg : dataA_x;
    wire [31:0] prevBypassA2 = ((rd_m != 5'b00000) &(rd_m == rs_x) & (opcode_x != 5'b00111)) ? dataFromALU_m : prevBypassA;
    wire [31:0] intoDataA = ((rs_x == rd_w) & (opcode_x == 5'b00111 | opcode_x == 5'b00110) & (opcode_w != 5'b00111)) ? data_writeReg : prevBypassA2;

    wire [31:0] prevBypassB = ((rd_w != 5'b00000) & (rd_w == rt_x) & (opcode_x != 5'b00111)) ? data_writeReg : dataB_x;
    wire [31:0] prevBypassB2 = ((rd_m != 5'b00000) & (rd_m == rt_x) & (opcode_x != 5'b00111 | opcode_m != 5'b00110)) ? dataFromALU_m : prevBypassB;
    wire [31:0] prevBypassB3 = ((rd_x == rd_d) & (opcode_d == 5'b00100 | opcode_x == 5'b00110)) ? aluOUT : prevBypassB2;
    wire [31:0] prevBypassB4 = ((rd_m == rd_x) & (opcode_x == 5'b00110)) ? dataFromALU_m : prevBypassB3;
    wire [31:0] intoDataB = addImmediate ? immediate_x : prevBypassB4;
    
    // stall?
    wire isDoingMult = isALU_x & (ALUop_x == 5'b00110);
    wire isDoingDiv = isALU_x & (ALUop_x == 5'b00111);

    wire dff_mOut, dff_dOut;

    dffe_ref isMult(.q(dff_mOut), .d(isDoingMult), .clk(~clock), .en(1'b1), .clr(mdReady)); 
    dffe_ref isDiv(.q(dff_dOut), .d(isDoingDiv), .clk(~clock), .en(1'b1), .clr(mdReady)); 

    wire ctrl_mult = isDoingMult & ~dff_mOut;
    wire ctrl_div = isDoingDiv & ~dff_dOut;
    assign stalling = (dff_mOut | dff_dOut);

    multdiv multiplier(.data_operandA(intoDataA), .data_operandB(intoDataB), .ctrl_MULT(ctrl_mult), .ctrl_DIV(ctrl_div), .clock(~clock), .data_result(mdOUT), .data_exception(mdExcept), .data_resultRDY(mdReady));
    // assign mdOut = 32'b0;

    alu ALUunit(.data_operandA(intoDataA), .data_operandB(intoDataB), .ctrl_ALUopcode(ALUop_x), .ctrl_shiftamt(shiftamt_x), .data_result(aluOUT), .isNotEqual(aluNE), .isLessThan(aluLT), .overflow(aluOVF), .multdivAns(mdOUT));

    wire [31:0] alu_exp1 = (aluOVF & isALU_x & ALUop_x==5'b0) ? 32'd1 : aluOUT;
    wire [31:0] inst_exp1 = (aluOVF & isALU_x & ALUop_x==5'b0) ? 32'b00000111100000000000000000000001 : instInExecute;
    wire [31:0] alu_exp2 = (aluOVF & isADDI_x) ? 32'd2 : alu_exp1;
    wire [31:0] inst_exp2 = (aluOVF & isADDI_x) ? 32'b00000111100000000000000000000010 : inst_exp1;
    wire [31:0] alu_exp3 = (aluOVF & isALU_x & ALUop_x==5'b00001) ? 32'd3 : alu_exp2;
    wire [31:0] inst_exp3 = (aluOVF & isALU_x & ALUop_x==5'b00001) ? 32'b00000111100000000000000000000011 : inst_exp2;
    wire [31:0] alu_exp4 = (mdExcept & isALU_x & ALUop_x==5'b00110) ? 32'd4 : alu_exp3;
    wire [31:0] inst_exp4 = (mdExcept & isALU_x & ALUop_x==5'b00110) ? 32'b00000111100000000000000000000100 : inst_exp3;
    wire [31:0] alu_exp5 = (mdExcept & isALU_x & ALUop_x==5'b00111) ? 32'd5 : alu_exp4;
    wire [31:0] inst_exp5 = (mdExcept & isALU_x & ALUop_x==5'b00111) ? 32'b00000111100000000000000000000101 : inst_exp4;

    wire [31:0] dataB_xm = isJAL_x ? PC_latchDX : dataB_x;

    adder getPCforJR(.A(PC_latchDX), .B(immediate_x), .C0(1'b0), .sum(pc_branch), .overflow());



    assign branching = isBLT_x & (aluNE & ~aluLT);

    wire [31:0] instInXM = stalling ? 32'b0 : inst_exp5; // pushing a nop through the rest of stalling


    








    // assign PC_Execute = isJR_x ? intoDataB : PC_latchDX;

    // XM latches
    wire [31:0] instInMemory, dataFromALU_m, dataB_m;
    gRegister #(32) IN_XMlatch (.clk(~clock), .in_en(1'b1), .in_data(instInXM), .out_data(instInMemory), .reset(reset));

    gRegister #(32) XM_ALUdata (.clk(~clock), .in_en(1'b1), .in_data(alu_exp5), .out_data(dataFromALU_m), .reset(reset));
    gRegister #(32) XM_RegB (.clk(~clock), .in_en(1'b1), .in_data(dataB_xm), .out_data(dataB_m), .reset(reset));

    
    gRegister #(32) pc1_m (.clk(~clock), .in_en(~stalling), .in_data(PCplus1_x), .out_data(PCplus1_m), .reset(reset));

    // memory stage 
    wire [4:0] rd_m, rs_m, rt_m;
    assign {opcode_m, rd_m, rs_m, rt_m} = instInMemory[31:12];

    wire storeWord = (opcode_m==5'b00111);
    wire loadWord = (opcode_m==5'b01000);


    // write to memory
    assign wren = storeWord;
    assign address_dmem = dataFromALU_m; // assume you get q_dmem immediately


    // bypass
    wire [31:0] dataToStore = storeWord ? dataB_m : 0;
    assign data = ((rd_w == rd_m) & (storeWord | loadWord)) ? data_writeReg : dataToStore;
    
    

    






    // MW Latches
    wire [31:0] instInWrite, dataFromMEM_w, dataFromALU_w, storeInstForJAL;

    register IN_MWlatch (.clk(~clock), .in_en(1'b1), .in_data(instInMemory), .out_data(instInWrite), .reset(reset));
    gRegister #(32) MW_ALUdata (.clk(~clock), .in_en(1'b1), .in_data(dataFromALU_m), .out_data(dataFromALU_w), .reset(reset));
    gRegister #(32) MW_MEMdata (.clk(~clock), .in_en(1'b1), .in_data(q_dmem), .out_data(dataFromMEM_w), .reset(reset));     
    gRegister #(32) pc1_w (.clk(~clock), .in_en(~stalling), .in_data(PCplus1_m), .out_data(PCplus1_w), .reset(reset));




    // writeback stage   
    wire [4:0] opcode_w, rd_w, rs_w, rt_w;
    assign {opcode_w, rd_w, rs_w, rt_w} = instInWrite[31:12];

    wire isJAL_w = (opcode_w == 5'b00011);
    wire isJR_w = (opcode_w == 5'b00100);
    wire isLW_w = (opcode_w == 5'b01000);

    wire isALU_w = (opcode_w == 5'b00000);
    wire isADDI_w = (opcode_w == 5'b00101);
    wire isSETX_w = (opcode_w == 5'b10101);
    

    // writing to register
    assign ctrl_writeReg = isJAL_w ? 31 : instInWrite[26:22];
    wire [31:0] fromALU = isJAL_w ? PCplus1_w : dataFromALU_w;
    assign data_writeReg = isLW_w ? dataFromMEM_w : fromALU;
    assign ctrl_writeEnable = (isALU_w | isADDI_w | isJAL_w | isSETX_w | isLW_w);










    // update PC

    wire PC_b = branching ? pc_branch : PCplus1;
    // assign intoPC = fastBranch ? PC_FastBranch : PC_b;
    // assign intoPC = PC_b;
    

	/* END CODE */

endmodule
