module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input logic clock,reset, ParallelLoadn, RotateRight, ASRight;
	input logic [3:0] Data_IN;
	output logic [3:0] Q;
	
	
	logic D3, D2, D1, D0;
	
	always_comb
	//begin
	if (!ParallelLoadn) begin// Load data (==0) 
		assign D3 = Data_IN[3];
		assign D2 = Data_IN[2];
		assign D1 = Data_IN[1];
		assign D0 = Data_IN[0];
	end
	else begin// Register is rotating
		if (!RotateRight) begin// Rotate flip flops left
			assign D3 = Q[2];
			assign D2 = Q[1];
			assign D1 = Q[0];
			assign D0 = Q[3];
		end
		else begin
			if (!ASRight) begin
				assign D3 = Q[0];
				assign D2 = Q[3];
				assign D1 = Q[2];
				assign D0 = Q[1];
			end
			else begin
				assign D3 = Q[3];
				assign D2 = Q[3];
				assign D1 = Q[2];
				assign D0 = Q[1];
			end
		end
	end
		
	D_flip_flop u3(clock, reset, D3, Q[3]);
	D_flip_flop u2(clock, reset, D2, Q[2]);
	D_flip_flop u1(clock, reset, D1, Q[1]);
	D_flip_flop u0(clock, reset, D0, Q[0]);
	
endmodule

module D_flip_flop(input logic clk, reset_b, d,
					output logic q);
	always_ff @(posedge clk)
	begin 
		if (reset_b) q <= 1'b0;
		else q <= d;
	end 
endmodule 

// module mux2to1(x, y, s, m);
    // input logic x; //select 0
    // input logic y; //select 1
    // input logic s; //select signal
    // output logic m; //output
  
    // assign m = s & y | ~s & x; 

// endmodule