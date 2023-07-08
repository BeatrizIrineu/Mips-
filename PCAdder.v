module PCAdder(input [31:0]adress_to_add, output reg [31:0]adress_added, input Jal, input Jump,
					input JR, input Branch, input [31:0] jumpLinkAdress, input [31:0] jumpAdress,
					input [26:0] jumpRegister, input [31:0] branchAdress);

	reg [31:0] next_pc;
	
	always @(adress_to_add)
	begin
			next_pc <= adress_to_add + 1;
		
		if(Jal)
			adress_added <= jumpLinkAdress;
		
		if(Jump) 
			adress_added <= jumpAdress;
		
		if(JR)
			adress_added <= jumpRegister;
		
		if(Branch==1 && branchAdress != -1)
			adress_added <= branchAdress;
		
		else if (!Jal && !Jump && !JR && (!Branch || (Branch && branchAdress == -1)))
			adress_added <= next_pc;
	end
endmodule