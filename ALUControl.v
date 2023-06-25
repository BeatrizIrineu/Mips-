module ALUControl(
  input[5:0] opcode,
  input [5:0] funct,
  input [4:0] shamt,
  output reg [3:0] ALUCtrl
);
  
always @(*) begin
	case (opcode)
	
		6'b001000: //addI
			ALUCtrl <= 4'b0010;
		
		6'b101011, 6'b100011: //sw, lw
			ALUCtrl <= 4'b1010;
			
		6'b000011: 	//jump and link
			ALUCtrl <= 4'b1110;
		
		6'b000100: //beq
			ALUCtrl <= 4'b1100;
			
		 6'b000101: //bne
			ALUCtrl <= 4'b0100;
			
		6'b000000: // R-type instructions
			case (funct)
				6'b100000: // add
					ALUCtrl <= 4'b0010;
				6'b100100: // and
					ALUCtrl <= 4'b1011;
				6'b100111:// not
					ALUCtrl <= 4'b1001;
				6'b000000: // shift left logical
					ALUCtrl <= 4'b0101;
				6'b000010: // shift right logical
					ALUCtrl <= 4'b1000;
				6'b100010: // sub
					ALUCtrl <= 4'b0110;
				6'b100101: // or
					ALUCtrl <= 4'b0001;
				6'b100100: // and
					ALUCtrl <= 4'b0000;
				6'b101010: // set less than
					ALUCtrl <= 4'b0111;
				6'b011000: //mult
					ALUCtrl <= 4'b1111;
				6'b011010: //div
					ALUCtrl <= 4'b0011;
				6'b001000: //jump register
					ALUCtrl <= 4'b0000;
			endcase
			
		
		default:
			ALUCtrl <= 4'b1111;
				
	endcase
end

endmodule
