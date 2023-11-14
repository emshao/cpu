module decoder #(parameter SIZE = 32) (out, select, enable); 
    input [4:0] select; 
    input enable; 
    output [SIZE-1:0] out; 
    
    assign out = enable << select; 

endmodule