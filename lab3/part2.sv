module part2(A, B, Function, ALUout);
	input logic [3:0] A,B;
	input logic [1:0] Function; //0,1,2,3
	output logic [7:0] ALUout;
	
	//case 0 
	logic [3:0] carry, sum;
	part1 u1(A,B,0,sum,carry);
	
	//case 1 A OR B 
	logic [7:0] case1;
	logic [7:0] case2;
	always_comb
		begin
			if (|{A,B})
				case1 = 8'b00000001;
			else
				case1 = 8'b00000000;
			
			
		//case 1 A AND B 
			if (&{A,B})
				case2 = 8'b00000001;
			else
				case2 = 8'b00000000;
			
		
			case(Function)
			2'b00: ALUout = {carry,sum};
			2'b01: ALUout = case1;
			2'b10: ALUout = case2;
			2'b11: ALUout = {A,B};
			default: ALUout = 8'b00000000;
			endcase
		end
endmodule 

module part1(a, b, c_in, s, c_out);
	input logic c_in;
	input logic [3:0] a,b;
	output logic [3:0] s,c_out;
	
	full_adder u_0(a[0],b[0],c_in,s[0],c_out[0]);
	full_adder u_1(a[1],b[1],c_out[0],s[1],c_out[1]);
	full_adder u_2(a[2],b[2],c_out[1],s[2],c_out[2]);
	full_adder u_3(a[3],b[3],c_out[2],s[3],c_out[3]);

endmodule 

module full_adder(input logic a, b, c_in,
				output logic s, c_out);
	
	assign s = a^b^c_in;
	assign c_out = (a&b)|(a&c_in)|(c_in&b);

endmodule 
