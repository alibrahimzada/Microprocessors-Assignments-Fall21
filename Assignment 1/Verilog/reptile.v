//Reptile design with 8 Registers. 
// This module also sents register #0 to main module as an output


module reptile (
					input clk,
					input [15:0] data_in,
					output [15:0] data_out,
					output reg [11:0] address,
					output memwt,
					output [15:0] reg0
					);
 
    reg [11:0] pc, ir; //program counter, instruction register
 
    reg [4:0]  state; //FSM
	 reg [15:0] regbank [7:0];//registers 
    reg zeroflag; //zero flag register
	 reg [15:0] result; //output for result
 
 
     localparam   FETCH=4'b0000,
                  LDI=4'b0001, 
                  LD=4'b0010,
                  ST=4'b0011,
                  JZ=4'b0100,
                  JMP=4'b0101,
                  ALU=4'b0111;
 
	 
    wire zeroresult; //zeroflag value 
 
    always @(posedge clk)
        case(state)
 
            FETCH: 
            begin
                if ( data_in[15:12]==JZ) // if instruction is jz  
                    if (zeroflag)  //and if last bit of 7th register is 0 then jump to jump instruction state
                        state <= JMP;
                    else
                        state <= FETCH; //stay here to catch next instruction
                else
                    state <= data_in[15:12]; //read instruction opcode and jump the state of the instruction to be read
                ir<=data_in[11:0]; //read instruction details into instruction register
                pc<=pc+1; //increment program counter
            end
 
            LDI:
            begin
                regbank[ ir[2:0] ] <= data_in; //if inst is LDI get the destination register number from ir and move the data in it.
                pc<=pc+1; //for next instruction (32 bit instruction)  
                state <= FETCH;
            end
 
             LD:
                begin
                    regbank[ir[2:0]] <= data_in;
                    state <= FETCH;  
                end 
 
            ST:
                begin
						  state <= FETCH;  
                end    
 
            JMP:
                begin
                    pc <= pc+ir;
                    state <= FETCH;  
                end          
 
            ALU:
                begin
                    regbank[ir[2:0]]<=result;
                    zeroflag<=zeroresult;
                    state <= FETCH;
                end
 
        endcase
 
 
 
    always @*   
        case (state)
            LD:      address=regbank[ir[5:3]][11:0];
            ST:      address=regbank[ir[5:3]][11:0];
            default: address=pc;
         endcase
 
 
 assign memwt=(state==ST);
 
 assign data_out = regbank[ir[8:6]];
    always @*
        case (ir[11:9])
            3'h0: result = regbank[ir[8:6]]+regbank[ir[5:3]]; //000
            3'h1: result = regbank[ir[8:6]]-regbank[ir[5:3]]; //001
            3'h2: result = regbank[ir[8:6]]&regbank[ir[5:3]]; //010
            3'h3: result = regbank[ir[8:6]]|regbank[ir[5:3]]; //011
            3'h4: result = regbank[ir[8:6]]^regbank[ir[5:3]]; //100
            3'h7: case (ir[8:6])
                        3'h0: result = !regbank[ir[5:3]];
                        3'h1: result = regbank[ir[5:3]];
                        3'h2: result = regbank[ir[5:3]]+1;
                        3'h3: result = regbank[ir[5:3]]-1;
                        default: result=16'h0000;
                    endcase
            default: result=16'h0000;
        endcase
 
   assign zeroresult = ~|result;

	assign reg0=regbank[0];
    initial begin;
            state=FETCH;
				zeroflag=0;
				pc=0;
            end                        
endmodule