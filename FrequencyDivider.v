module FrequencyDivider #(parameter cycles = 0) 
(input clk_in, output clk_out);
	
	reg clock; 
	
	initial
	begin	
		clock = 1;
	end
	
	integer count_cycles = 1;

	always @(posedge clk_in)
	begin
		if (count_cycles < cycles)
		begin
			count_cycles = count_cycles + 1;
		end
		else begin
			count_cycles = 0;
			clock = ~clock;
		end	
	end
	assign clk_out = clock;

endmodule
