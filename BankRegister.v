module BankRegister
(
input clk, input pause, input reset,input RegWrite, input Jal,
input [4:0]source, input [4:0] target, input [4:0]target_or_destination,  input [4:0] print_adress,
output [31:0] read_register_1, output [31:0]read_register_2, output [31:0] print_register, input[31:0] write_data, input[31:0] pc
);
	
	
	//registrador 31 para guardar endereço de retorno
	
	integer i;
	reg [31:0]registers [31:0];
	
	assign read_register_1 = registers[source];
	assign read_register_2 = registers[target];
	assign print_register = registers[print_adress];
	
	always @(posedge clk)
	begin
		
		if (reset == 1) 
		begin 
			for (i = 0; i < 32; i=i+1) 
			begin
				registers[i] <= 32'b0;
			end
		end 
			
		else if (RegWrite) registers[target_or_destination] <= write_data;
			
		else if (Jal == 1) registers[31] <= pc + 1;
	
	end

endmodule

	