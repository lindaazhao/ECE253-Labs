module part3 #(parameter CLOCK_FREQUENCY=500) (ClockIn, Reset, Start, Letter, DotDashOut, NewBitOut);
    input logic ClockIn, Reset, Start;
    input logic [2:0] Letter;
    output logic DotDashOut, NewBitOut;

    logic [11:0] encoding, out_sequence;

    always_comb
	begin
		if (Reset | Start) begin
            case(Letter)
                0: encoding = 12'b101110000000;
                1: encoding = 12'b111010101000;
                2: encoding = 12'b111010111010;
                3: encoding = 12'b111010100000;
                4: encoding = 12'b100000000000;
                5: encoding = 12'b101011101000;
                6: encoding = 12'b111011101000;
                7: encoding = 12'b101010100000;
                default: encoding = 12'b000000000000;
            endcase
        end
	end

    logic started; // Use to sync/start the NewBitOut "clock" once Start has been switched on
    always_ff @(posedge ClockIn)
    begin
        if (Start & !Reset) begin
            started <= 1;
        end
        else if (Reset) begin
            started <= 0;
        end
    end

    RateDivider #(CLOCK_FREQUENCY) u0(ClockIn, Reset, started, NewBitOut);
    DotDashOutGen u1(ClockIn, Reset, Start, NewBitOut, encoding, DotDashOut);
endmodule

module DotDashOutGen (ClockIn, Reset, Start, NewBitOut, encoding, DotDashOut);
    input logic ClockIn, Reset, NewBitOut, Start;
    input logic [11:0] encoding;
    output logic DotDashOut;

    logic [11:0] out_sequence;

    always_ff @(posedge ClockIn)
    begin
        if (Reset) begin
            out_sequence <= 0;
        end
        else begin
            if (Start) begin // Get encoding once started
                out_sequence <= encoding;
            end
            else if (NewBitOut) begin // Shift MSB out on each NewBitOut edge
                out_sequence <= {out_sequence[10:0], 1'b0};
            end
        end
    end

    assign DotDashOut = out_sequence[11];
endmodule


module RateDivider #(parameter CLOCK_FREQUENCY = 500) (
	input logic ClockIn,
	input logic Reset,
    input logic started,
	output logic Enable);	
	
	logic [$clog2(CLOCK_FREQUENCY/2):0] counter; // Maximum size required for counter
	
	always_ff @(posedge ClockIn)
	begin
        if (Reset | counter == 0) begin // Set clock countdown 
            counter <= (CLOCK_FREQUENCY/2) - 1;
        end
        else if (started) begin // Start decrementing only after Start has been triggered
            counter <= counter - 1;
        end
        else begin // Do not change counter if not started (e.g. NewBitOut clock will be 0)
            counter <= counter;
        end
	end

    assign Enable = (counter == 'b0)? '1:'0;
endmodule