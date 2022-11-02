
module part2(Clock, Reset_b, Data, Function, ALUout); 
	input logic Clock, Reset_b; 
	input logic [1:0] Function;
	input logic [3:0] Data;
	output logic [7:0] ALUout;
	
	logic [7:0] temp_ALU;
	
	//case 0
	logic [7:0] case0, case1, case2, register;
	assign case0 = Data + ALUout[3:0]; //least sig bit of ALUout is B
	assign case1 = Data * ALUout[3:0];
	assign case2 = ALUout[3:0] << Data; 
	
	
	always_comb
		begin
			case(Function)
			2'b00: temp_ALU = case0;
			2'b01: temp_ALU = case1;
			2'b10: temp_ALU = case2;
			2'b11: temp_ALU = ALUout;
			default: temp_ALU = 0;
			endcase
		end
		
	D_flip_flop u0(Clock, Reset_b, temp_ALU, ALUout); //send through register (modified 8 FF)
		
endmodule 

// module D_flip_flop(input logic clk, reset_b, d,
					// output logic q);
	// always_ff @(posedge clk)
	// begin 
		// if (reset_b) q <= 1'b0;
		// else q <= d;
	// end 
// endmodule 

module D_flip_flop(clk, reset_b, d, q);
	input logic clk, reset_b;
	input logic [7:0] d;
	output logic [7:0] q;
	always_ff @(posedge clk)
	begin 
		if (reset_b) q <= 8'b00000000;
		else q <= d;
	end 
endmodule 

