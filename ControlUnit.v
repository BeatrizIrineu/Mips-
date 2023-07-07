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
  output reg RegWrite, 
  output reg Jump,
  output reg Jal,
  output reg print,
  output reg in, 
  output reg [1:0] bits_16_26,
  output reg pause
);

  always @(*)
    case (opcode)
	 
      // R-format
      6'b000000:  
			begin
				RegDst    <= 2'b01;
				Branch    <= 0;
				MemRead   <= 0;
				MemtoReg  <= 2'b00;
				ALUOp     <= 2'b00;  
				MemWrite  <= 0;
				ALUSrc    <= 0;
				RegWrite  <= 1;
				Jump      <= 0;
				Jal       <= 0;
				print     <= 0;
				in		    <= 0;
				bits_16_26<= 0;
				pause	  <= 0;
				
			end
		
		// addI
		6'b001000:  
			begin
				RegDst    <= 2'b00;
				Branch    <= 0;
				MemRead   <= 0;
				MemtoReg  <= 2'b00;
				ALUOp     <= 2'b00;  
				MemWrite  <= 0;
				ALUSrc    <= 1;
				RegWrite  <= 1;
				Jump      <= 0;
				Jal       <= 0;
				print     <= 0;
			   in		    <= 0;
				bits_16_26<= 2'b11;
				pause	  <= 0;
			end
			
		//Jump adress
		6'b000010:  
			begin
				RegDst    <= 2'b00; 
				Branch    <= 0;
				MemRead   <= 0;
				MemtoReg  <= 2'b00; 
				ALUOp     <= 2'b00;  
				MemWrite  <= 0;
				ALUSrc    <= 0;
				RegWrite  <= 0;
				Jump      <= 1;
				Jal       <= 0;
				print     <= 0;
				in		    <= 0;
				bits_16_26<= 2'b00;
				pause	  <= 0;
			end
				
		//Jump and Link
		6'b000011:  
			begin
				RegDst    <= 2'b00; 
				Branch    <= 0;
				MemRead   <= 0;
				MemtoReg  <= 2'b00; 
				ALUOp     <= 2'b01;  
				MemWrite  <= 0;
				ALUSrc    <= 1;
				RegWrite  <= 0;
				Jump      <= 0;
				Jal       <= 1;
				print     <= 0;
				in		    <= 0;
				bits_16_26<= 2'b00;
				pause	  <= 0;
			end
			
		// lw
      6'b100011:
        begin
          RegDst    <= 2'b00;
          Branch    <= 0;
          MemRead   <= 1;
          MemtoReg  <= 2'b01;  
          ALUOp     <= 2'b11;  
          MemWrite  <= 0;
          ALUSrc    <= 1;
          RegWrite  <= 1;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 0;
			 bits_16_26<= 2'b11;
			 pause	  <= 0;
        end
	
		// sw
      6'b101011:
        begin
          RegDst    <= 2'b00; //Indiferente
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00; //Indiferente
          ALUOp     <= 2'b11;
          MemWrite  <= 1;
          ALUSrc    <= 1;
          RegWrite  <= 0;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 0;
			 bits_16_26<= 2'b11;
			 pause	  <= 0;
        end
		  

		// beq
		6'b000100:
		  begin
			 RegDst    <= 2'b00; // Indiferente
			 Branch    <= 1;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b10;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 0;
			 bits_16_26<= 2'b11;
			 pause	  <= 0;
		  end
		  
	  //bne
      6'b000101: 
		  begin
			 RegDst    <= 2'b00; // Indiferente
			 Branch    <= 1;
			 MemRead   <= 0;
			 MemtoReg  <= 2'b00; // Indiferente
			 ALUOp     <= 2'b00;  
			 MemWrite  <= 0;
			 ALUSrc    <= 0;
			 RegWrite  <= 0;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in        <= 0;
			 bits_16_26<= 2'b11;
			 pause	  <= 0;
		  end
		  		  
		// lui
		6'b001111:
		  begin
			  RegDst    <= 2'b00; // Indiferente
			  Branch    <= 0;	// Indiferente
			  MemRead   <= 0;	
			  MemtoReg  <= 2'b10;
			  ALUOp     <= 2'b00;
			  MemWrite  <= 0;
			  ALUSrc    <= 0; // Indiferente
			  RegWrite  <= 1;
			  Jump      <= 0;
			  Jal       <= 0;
			  print     <= 0;
			  in		   <= 0;
			  bits_16_26<= 2'b11;
			  pause	  <= 0;
		  end

		  
		 // print
		6'b111111:
        begin
          // Instrução não reconhecida
          RegDst    <= 2'b00;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00;
          ALUOp     <= 2'b00;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 1;
			 in		  <= 0;
			 bits_16_26<= 2'b00;
			 pause	  <= 0;
        end

		   // input
		6'b111000:
        begin
          // Instrução não reconhecida
          RegDst    <= 2'b10;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b10;
          ALUOp     <= 2'b00;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 1;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 1;
			 bits_16_26<= 2'b01;
			 pause	  <= 0;
        end
		  
		  //pause
		6'b000111:
		 begin
          RegDst    <= 2'b00;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00;
          ALUOp     <= 2'b00;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 1;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 0;
			 bits_16_26<= 2'b00;
			 pause	  <= 1;
			end
			
      default:
        begin
          // Instrução não reconhecida
          RegDst    <= 2'b00;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 2'b00;
          ALUOp     <= 2'b00;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
			 Jump      <= 0;
			 Jal       <= 0;
			 print     <= 0;
			 in		  <= 0;
			 bits_16_26<= 2'b00;
			 pause	  <= 0;
        end
		  
    endcase

endmodule