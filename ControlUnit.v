module ControlUnit(
  input [5:0] opcode,
  output reg RegDst,
  output reg Branch,
  output reg MemRead,
  output reg MemtoReg,
  output reg [2:0] ALUOp,
  output reg MemWrite,
  output reg ALUSrc,
  output reg RegWrite
);

  always @(*)
    case (opcode)
      // add, sub, mult, div, set less than, or, and, not, shift left logical, shift right logical
      6'b000000:  
        begin
          RegDst    <= 1;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 0;
          ALUOp     <= 3'b000;  // ALUOp for add, sub, mult, div, set less than
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 1;
        end
      
      // addI, load immediate
      6'b001000:
        begin
          RegDst    <= 0;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 0;
          ALUOp     <= 3'b000;  // ALUOp for addI
          MemWrite  <= 0;
          ALUSrc    <= 1;
          RegWrite  <= 1;
        end
      
      // lw, sw
      6'b100011:
        begin
          RegDst    <= 0;
          Branch    <= 0;
          MemRead   <= 1;
          MemtoReg  <= 6'b100;  // MemtoReg for lw
          ALUOp     <= 3'b000;  // ALUOp for lw, sw
          MemWrite  <= 1;
          ALUSrc    <= 1;
          RegWrite  <= 1;
        end
      
      // br.eq, br.neq
      6'b010101, 6'b010100:
        begin
          RegDst    <= 0;
          Branch    <= 1;
          MemRead   <= 0;
          MemtoReg  <= 0;
          ALUOp     <= 3'b010;  // ALUOp for set less than
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
        end
      
      // jump, jump register, jump and link
      6'b000010, 6'b000000, 6'b001111:
        begin
          RegDst    <= 0;
          Branch    <= 1;
          MemRead   <= 0;
          MemtoReg  <= 0;
          ALUOp     <= 3'b000;  
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
        end
      
      default:
        begin
          // Instrução não reconhecida
          RegDst    <= 0;
          Branch    <= 0;
          MemRead   <= 0;
          MemtoReg  <= 0;
          ALUOp     <= 3'b000;
          MemWrite  <= 0;
          ALUSrc    <= 0;
          RegWrite  <= 0;
        end
    endcase

endmodule