module ALUControl(
  input [5:0] funct,
  input [1:0] ALUOp,
  input [4:0] shamt,
  output reg [3:0] ALUCtrl
);
  
always @(*) begin
	case (funct)
		// R-type instructions (AND, OR, subtract, add, or set on less than)
		6'b100000, 6'b001001: // add, addI
			ALUCtrl <= 4'b0010;
		6'b100010, 6'b001011: // sub, subI
			ALUCtrl <= 4'b0110;
		6'b100101: // or
			ALUCtrl <= 4'b0001;
		6'b100100: // and
			ALUCtrl <= 4'b0000;
		6'b101010: // set less than
			ALUCtrl <= 4'b0111;
		6'b011000: //mult
			ALUCtrl <= 4'b1111;
		6'b011000: //div
			ALUCtrl <= 4'b0011;
		// Shift instructions
		6'b000000: // shift left logical, shift right logical, not
			case (shamt)
				5'b00000: // shift left logical
				  ALUCtrl <= 4'b0101;
				5'b00010: // shift right logical
				  ALUCtrl <= 4'b1000;
				default: // not
				  ALUCtrl <= 4'b1001;
			endcase
	  
	  default:
		 ALUCtrl <= 4'b0000;
	endcase
end

endmodule
