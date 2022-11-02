module part2 #(parameter CLOCK_FREQUENCY = 500)(
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic [3:0] CounterValue);
	
	logic EnableDC;
	RateDivider u0(ClockIn, Reset, Speed, EnableDC);
	DisplayCounter u1(ClockIn, Reset, EnableDC, CounterValue);
endmodule

module RateDivider #(parameter CLOCK_FREQUENCY = 500) (
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic Enable);	
	
	logic [$clog2(CLOCK_FREQUENCY*4):0] counter; // Maximum size required for counter
	
	always_ff @(posedge ClockIn)
	begin
		if (Reset == 1 | counter == 0) begin // Respond to speed change on reset 
			case(Speed)
				2'b00: counter = 0;
				2'b01: counter = CLOCK_FREQUENCY - 1;
				2'b10: counter = CLOCK_FREQUENCY * 2 - 1;
				2'b11: counter = CLOCK_FREQUENCY * 4 - 1;
				default: counter = 0;
			endcase
		end 
		
		else begin
			counter <= counter - 1;
		end
	end
	
	always_comb begin
		if (!Speed & counter == 'b0) begin
			assign Enable = ClockIn;
		end
		else begin
			assign Enable = (counter == 'b0)? '1:'0;
		end
	end
endmodule



module DisplayCounter (	
	input logic Clock,
	input logic Reset,
	input logic EnableDC,
	output logic [3:0] CounterValue);

	always_ff @(posedge Clock)
		if (Reset)
			CounterValue <= 0;

	always_ff @(posedge EnableDC)
		if (!Reset)
			CounterValue <= CounterValue + 1;

endmodule