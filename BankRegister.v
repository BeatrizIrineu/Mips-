module BankRegister(input clk, input read, input print, input pause, input reset,input RegWrite, input Jal,
							input [4:0]source, input [4:0] target, input [4:0]target_or_destination,
							output [31:0] read_register_1, output [31:0]read_register_2,  input[31:0] write_data, input[31:0] pc
							);
	
	
	//registrador 31 para guardar endereço de retorno
	
	integer i;
	reg [31:0]registers [31:0];
	
	assign read_register_1 = (print == 0) ? registers[source] : read_register_1;
	assign read_register_2 = (print == 0) ? registers[target] : read_register_2;
	
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

	