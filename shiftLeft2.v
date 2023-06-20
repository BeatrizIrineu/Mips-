module shiftLeft2(
  input [25:0] signToShift,
  input [3:0] adress_to_add,
  output [31:0] jumpAdress
);
  
  assign JumpAdress = {adress_to_add,signToShift << 2};
 
endmodule
