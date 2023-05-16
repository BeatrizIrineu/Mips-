module BankRegister(input clk, input PC, input write, input reset, input jal,
							input [4:0]rd, input [4:0]rs, input [4:0]rt,	
							output [31:0] out_rs, output [31:0]out_rt, output [31:0]out_rd, input[31:0] data
							);
	
	
	//registrador 31 para guardar endereço de retorno
	
	integer i;
	reg [31:0]registers [31:0];
	
	always @(posedge clk) 
	
		begin
		
		if (reset == 1) 
			begin 
			for (i = 0; i < 32; i=i+1) 
				begin
				registers[i] <= 32'b0;
				end
			end 
			
		else if (write == 1) 
			begin 
			registers[rd] <= data;
				
				if (jal == 1)
					begin
					registers[31] <= PC;
					end
			end	
			
		end
		

	assign out_rs = registers[rs];
	assign out_rt = registers[rt];
	assign out_rd = registers[rd];

endmodule