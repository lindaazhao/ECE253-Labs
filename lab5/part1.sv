module part1 (
	input logic Clock,
	input logic Enable,
	input logic Reset,
	output logic [7:0] CounterValue);
	
	logic w0,w1,w2,w3,w4,w5,w6;
	
	T_FF u0(Enable, Clock, Reset, CounterValue[0]);
	
	assign w0 = CounterValue[0] & Enable;
	T_FF u1(w0, Clock, Reset, CounterValue[1]);
	
	assign w1 = CounterValue[1] & w0;
	T_FF u2(w1, Clock, Reset, CounterValue[2]);
	
	assign w2 = CounterValue[2] & w1;
	T_FF u3(w2, Clock, Reset, CounterValue[3]);
	
	assign w3 = CounterValue[3] & w2;
	T_FF u4(w3, Clock, Reset, CounterValue[4]);
	
	assign w4 = CounterValue[4] & w3;
	T_FF u5(w4, Clock, Reset, CounterValue[5]);
	
	assign w5 = CounterValue[5] & w4;
	T_FF u6(w5, Clock, Reset, CounterValue[6]);
	
	assign w6 = CounterValue[6] & w5;
	T_FF u7(w6, Clock, Reset, CounterValue[7]);

endmodule

module T_FF(input logic T, clock, resetn,
			output logic Q);
			
	always_ff@(posedge clock, negedge resetn)
	
	begin 
	if (resetn)
		Q <= 0;
	else
		if (T)
			Q <= !Q;
		else
			Q <= Q;
	end 
		
endmodule