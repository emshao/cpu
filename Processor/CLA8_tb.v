`timescale 1 ns / 100 ps
module CLA8_tb;

    reg [7:0] A, B;
    reg C0;

    wire [7:0] Sout;
    wire Gout, Pout;

    CLA8 adder8(.A(A), .B(B), .C0(C0), .S(Sout), .G(Gout), .P(Pout));

    reg[127:0] expFileName;
    integer expScan;

    initial begin
        
        // expFileName = "CLA8tests.csv";
        
		// expFile = $fopen(expFileName, "r");

        // if(!expFile) begin
		// 	$display("Couldn't read the output file.",
		// 		"\nMake sure you are in the right directory and the %0s_exp.csv file exists.", testName);
		// 	$finish;
		// end

        // expScan = $fscanf(expFile, "%s,%s,%s,%s,%s,%s,%s,%s", 
		// 	A, B, ALU_OP, Shift_Amt, ExpRes, ExpNE, ExpLT, ExpOVF);

        // if(expScan == 0) begin
		// 	$display("Error reading the %0s file.\nMake sure there are no spaces ANYWHERE in your file.\nYou can check by opening it in a text editor.", expFileName);
		// 	$finish;
		// end

        // expScan = $fscanf(expFile, "%d,%d,%d,%d,%d,%d,%d,%d",
		// 	A, B, ALU_OP, Shift_Amt, ExpRes, ExpNE, ExpLT, ExpOVF);

		// if(expScan != 8) begin
		// 	$display("Error reading %0s\nMake sure there are no spaces ANYWHERE in your file.\nYou can check by opening it in a text editor.", expFileName);
		// 	$finish;
		// end

        // while(expScan == 8) begin

		// 	#10;

        // end

        assign A = 8'h80;
        assign B = 8'h80;

        assign C0 = 1'b0;

        #2;

        $display("A: %b, B: %b, C0: %b => Sum: %b G: %b, P: %b", A, B, C0, Sout, Gout, Pout);


        $finish;
    end

endmodule