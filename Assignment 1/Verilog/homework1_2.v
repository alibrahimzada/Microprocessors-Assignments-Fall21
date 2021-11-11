
//This module sents Register #0 to seven segment display 

module homework1_2 (grounds, display, clk,led);
 
    output  [3:0] grounds;
    output  [6:0] display;
    input   clk; 
    output led;
 
    //  memory chip
    reg     [15:0] memory [0:127]; 
 
    // cpu's input-output pins
    wire     [11:0] pc; //for debugging
    wire     [15:0] data_out;
    wire     [15:0] data_in;
    wire     [11:0] address;
    wire     memwt;
 
    wire     [15:0] reg0;
 
 assign led=memwt; //check memory write signal works or not. For debugging 
 
    //instantiation of cpu
  reptile rr1 (.data_in(data_in), .data_out(data_out), .clk(clk), .memwt(memwt), .address(address),.reg0(reg0));
    //instantiation of seven segment
    sevensegment ss1 (.grounds(grounds), .display(display), .clk(clk),  .datain(reg0));
    
 
    assign data_in=memory[address];
    
	 always @(posedge clk)
		if (memwt==1)
			memory[address]<=data_out;
	
	
    initial begin
		$readmemh("ram.dat", memory);
    end
 
endmodule
