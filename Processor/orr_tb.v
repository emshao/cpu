module or_tb;

    reg [31:0] A, B, ExpOut;

    wire [31:0] out;

    orr o(.A(A), .B(B), .out(out));

    reg[95:0] dataOut;
    integer readInFile, outFile, scan;

    initial begin
        readInFile = $fopen("or_test.txt", "r"); //  ("or_test.csv", "r");
        outFile = $fopen("or_test_output.csv", "w");
        if(!readInFile) begin
            $display("Could not read input file for test.");
            $finish;
        end
        while(!feof(readInFile)) begin
            scan = $fscanf(readInFile, "%b", dataout);
            {A, B, ExpOut} = dataOut;
            #10;
            if((ExpOut != out)) 
                $fdisplay(outFile, "Failed: A: %b, B: %b, myOut: %b, Expected: %b", A, B, out, ExpOut);
        end
        $fclose(readInFile);
        $fclose(outFile);
        #100
        $finish;
    end

endmodule