module InstructionMemory(input [31:0] adress_memory_in, input pause, output [31:0] instruction);
	
	reg [31:0] ram[23:0];
	reg [31:0] memory_address;

	initial
	begin
		$readmemb("instrucoes.txt", ram);
	end
	
	always @ (*)
		begin
		if (pause != 1)
				memory_address <= adress_memory_in;
		end

	assign instruction = ram[memory_address];

endmodule
