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