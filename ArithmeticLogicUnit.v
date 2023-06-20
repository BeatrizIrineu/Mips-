module ArithmeticLogicUnit
	(
	input Jal, 
	input [31:0] pc,
	input [4:0] source,
	input [31:0] read_data_1, 
	input [31:0] read_data_2, 
	input [3:0] ALUCtrl,
	input shamt,
	output reg [31:0] ALU_result, 
	output Zero
);

	reg [63:0] HiLo;
	always @(*) begin 
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
			4'b0000: ALU_result <= read_data_1 & read_data_2;
				
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
			
		  default:
			 ALU_result <= 0;
		endcase
		
		if (Jal)
			begin
				ALU_result <= pc + (read_data_2 << 2);
			end
	
	end
	assign Zero = (ALU_result==0);

endmodule 