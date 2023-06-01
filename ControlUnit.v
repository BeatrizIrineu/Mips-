module ControlUnit(
  input [5:0] opcode,
  input [5:0] funct,
  output reg [1:0] RegDst,
  output reg Branch,
  output reg MemRead,
  output reg [1:0] MemtoReg,
  output reg [1:0] ALUOp,
  output reg MemWrite,
  output reg ALUSrc,
  output reg RegWrite
);

  always @(*)
    case (opcode)
	 
      // R-format or jr (jump register)
      6'b000000:  
			case(funct)
				//jr (jump register)
				6'b001000:
					begin
					 RegDst    <= 0; // Indiferente
					 Branch    <= 1;
					 MemRead   <= 0;
					 MemtoReg  <= 2'b00; // Indiferente
					 ALUOp     <= 2'b00;  
					 MemWrite  <= 0;
					 ALUSrc    <= 0;
					 RegWrite  <= 0;
				  end
			  //R-format
			  default:
				  begin
					 RegDst    <= 1;
					 Branch    <= 0;
					 MemRead   <= 0;
					 MemtoReg  <= 2'b00;
					 ALUOp     <= 2'b10;  
					 MemWrite  <= 0;
					 ALUSrc    <= 0;
					 RegWrite  <= 1;
				  end
			endcase
		
		// lw
      6'b100011:
        begin
          RegDst    <= 0;
          Branch    <= 0;
          MemRead   <= 1;
          MemtoReg  <= 2'b01;  
          ALUOp     <= 2'b00;  
          MemWrite  <= 0;
          ALUSrc    <= 1;
          RegWrite  <= 1;
        end
	
		// sw
      6'b101011:
        begin
          RegDst    <= 0; //Indiferente
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00; //Indiferente
          ALUOp     <= 2'b00; 
          MemWrite  <= 1;
          ALUSrc    <= 1;
          RegWrite  <= 0;
        end
		  
		// beq and bne
		6'b000100, 6'b000101:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 1;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b01;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
		  end

		  
		 //addI
      6'b001000: 
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 0;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 1;
			 RegWrite  <= 1;
		  end
		  
		 //subI
      6'b001010: 
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 0;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 1;
			 RegWrite  <= 1;
		  end
		  
			// lui
		6'b001111:
		  begin
			  RegDst    <= 0; // Indiferente
			  Branch    <= 0;	// Indiferente
			  MemRead   <= 0;	
			  MemtoReg  <= 2'b10;
			  ALUOp     <= 2'b00;
			  MemWrite  <= 0;
			  ALUSrc    <= 0; // Indiferente
			  RegWrite  <= 1;
		  end

		// ori
		6'b001101:
		  begin
			  RegDst    <= 0; // Indiferente
			  Branch    <= 0;
			  MemRead   <= 0;
			  MemtoReg  <= 2'b00;
			  ALUOp     <= 2'b01;
			  MemWrite  <= 0;
			  ALUSrc    <= 1;
			  RegWrite  <= 1;
		  end

      // j (jump)
		6'b000010:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 1;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
		  end


		// jal (jump and link)
		6'b000011:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 1;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 1;
		  end

      // mult (multiplicação)
		6'b011000:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 0;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
		  end

		// div (divisão)
		6'b011010:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 0;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b01;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
		  end

		// not (negação lógica)
		6'b011100:
		  begin
			 RegDst    <= 0; // Indiferente
			 Branch    <= 0;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b10;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 1;
		  end

      default:
        begin
          // Instrução não reconhecida
          RegDst    <= 0;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00;
          ALUOp     <= 2'b00;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
        end
		  
    endcase

endmodule