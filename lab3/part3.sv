module part3(A, B, Function, ALUout);
	parameter N = 3;
	input logic [N-1:0] A,B;
	input logic [1:0] Function; //0,1,2,3
	output logic [(N*2)-1:0] ALUout;
	
	//case 0
	logic [2*N-1:0] case0, case1, case2;
	assign case0 = A + B;
		
	
	always_comb
		begin
			//case 1 A OR B 
			if (|{A,B})
				case1 = 1;
			else
				case1 = 0;
			
			
			//case 1 A AND B 
			if (&{A,B})
				case2 = 1;
			else
				case2 = 0;
			
		
			case(Function)
			2'b00: ALUout = case0;
			2'b01: ALUout = case1;
			2'b10: ALUout = case2;
			2'b11: ALUout = {A,B};
			default: ALUout = 0;
			endcase
		end
endmodule 

//module mux(input logic x,y,s,
			//output logic f);
	//assign f = (~s&x)|(s&y);
//endmodule 
