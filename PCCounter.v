module PCCounter (input clk, input pause, input reset, input [31:0]adress_pc_in, output reg [31:0]adress_pc_out);

	always @(posedge clk) 
	begin
		if (reset == 1)
			adress_pc_out <= 31'b0;
		else if (pause == 0)	
			adress_pc_out <= adress_pc_in;
			
	end
		
endmodule