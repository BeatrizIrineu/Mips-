module ALUControl(
  input [5:0] func,
  output reg [2:0] ALUOp,
  output reg [1:0] ShiftLeft
);
  
  always @(*) begin
    case (func)
      6'b100000: // add
			ALUOp = 3'b000;
      6'b100010: // sub
			ALUOp = 3'b001;
      6'b011000: // mult
			ALUOp = 3'b010;
      6'b011010: // div
			ALUOp = 3'b011;
      6'b101010: // set less than
			ALUOp = 3'b100;
      6'b100101: // or
			ALUOp = 3'b101;
      6'b100100: // and
			ALUOp = 3'b110;
      6'b100111: // not
			ALUOp = 3'b111;
      6'b000000: // shift left logical (sll)
			ALUOp = 3'b011;
      6'b000010: // shift right logical (srl)
			ALUOp = 3'b011;
		6'b100001: //move
			ALUOp = 3'000;
		6'b001000: //jump register
			ALUOp = 3'000;
		default:
        ALUOp = 3'b000;
    endcase
  end

endmodule
