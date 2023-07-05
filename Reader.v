module Reader(input pause, input read_write_fpga, input sw0, input sw1, input sw2, input sw3, input sw4, input sw5, output reg [31:0] instruction);
	
	always@(*)
	begin
		if (pause===1 && read_write_fpga===1)
			instruction <= 0;
	end
	
endmodule
