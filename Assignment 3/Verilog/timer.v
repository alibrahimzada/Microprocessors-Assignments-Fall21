module timer(clk, button, statusordata, ack, timerout);
	input clk;
	input button;
	input statusordata;
	input ack;
	reg [15:0] counter;
	output reg [15:0] timerout;
	reg ready = 1'b0;
	reg pushbutton_data;
	reg pb_data;
	reg [15:0] data;
	
	reg [25:0] clk1;

	always @(posedge clk)
		clk1 <= clk1 + 1;		
		
	always @(posedge clk1[25])
		counter <= counter + 1;

	always @(posedge clk)
		if ((pushbutton_data==1'b1)&&(ready==0))
			begin
				data<=counter;
				ready<=1;
			end
		else if ((ack==1)&&(ready==1))
			begin
				ready<=0;
			end
	
	always @(posedge clk)
		begin
			if ((pushbutton_data==1'b0)&&(button==0))
				pushbutton_data<=1'b1;
			else if ((pushbutton_data==1'b0)&&(button==1))
				pushbutton_data<=1'b0;
			else if ((pushbutton_data==1'b1)&&(button==0))
				pushbutton_data<=1'b0;
			else if ((pushbutton_data==1'b1)&&(button==1))
				pushbutton_data<=1'b0;
		end
	
	always @(*)
		if (statusordata==1)
			timerout={15'b0,ready};
		else
			timerout=data;
				
	initial
		begin
			clk1 = 0;
			counter = 0;
			pushbutton_data = 0;
		end

endmodule
