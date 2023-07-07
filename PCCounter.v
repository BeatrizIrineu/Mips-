module PCCounter (input clk, input pause, input enter, input in, input reset, input [31:0]adress_pc_in, output reg [31:0]adress_pc_out);

	always @(posedge clk) 
	begin
		if (reset == 1)
			adress_pc_out <= 31'b0;
		if ((pause == 0 && (in == 0 && enter == 0)) || (pause == 0 && (in == 1 && enter == 1)))
			adress_pc_out <= adress_pc_in;

			
	end

endmodule

