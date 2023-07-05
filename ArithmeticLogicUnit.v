module ArithmeticLogicUnit
	(
	
	input [31:0] pc,
	input print, 
	input [4:0] source,
	input [31:0] read_data_1, 
	input [31:0] read_data_2, 
	input [3:0] ALUCtrl,
	input shamt,
	input [31:0] signal_extended,
	output reg [31:0] ALU_result 
);

	reg [63:0] HiLo;
	always @(ALUCtrl) begin 
		if (print == 0)
		begin
			case (ALUCtrl)
				// add, addI
				4'b0010: ALU_result <= read_data_1 + read_data_2;
				
				4'b1010: ALU_result <= source + read_data_2;
				
				// sub, subI
				4'b0110: ALU_result <= read_data_1 - read_data_2;
				
				// or
				4'b0001: 
					begin 
						if ((read_data_1 + read_data_2) > 1) 
							ALU_result <= 1;
						else 
							ALU_result <= 0;
					end
					
				// and
				4'b1011: ALU_result <= read_data_1 & read_data_2;
					
				// set less than	
				4'b0111: ALU_result <= (read_data_1 < read_data_2) ? 1 : 0;
						
				// shift left logical	
				4'b0101: ALU_result <= read_data_1 << shamt;
				
				// shift right logical
				4'b1000: ALU_result <= read_data_1 >> shamt;
				
				// not		 
				4'b1001: ALU_result <= ~read_data_1;
							  
				 // mult
				4'b1111:
					begin
					  HiLo <= read_data_1 * read_data_2;
					  ALU_result <= HiLo[31:0];
					end
				
				 // div
				4'b0011: 
					begin
						if (read_data_2 != 0) begin 
						  HiLo <= read_data_1 / read_data_2;
						  ALU_result <= HiLo[31:0];
						end
						else ALU_result <= 1;
					end
				
				
				4'b1100: //beq
					begin
						if (read_data_1 == read_data_2)
							ALU_result <= signal_extended;
						else ALU_result <= 0;
					end
				4'b0100: //bne
					begin
						if (read_data_1 != read_data_2)
							ALU_result <= signal_extended;
						else ALU_result <= 0;
					end
			  
			  default:
				 ALU_result <= 0;
			endcase	
		end
	end
	

endmodule 