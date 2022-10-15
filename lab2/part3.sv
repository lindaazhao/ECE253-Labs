`timescale 1ns / 1ns // `timescale time_unit/time_precision

module hex_decoder(c, display);
    input logic [3:0] c; // Inputs: c[3], c[2], c[1], c[0] from MSB to LSB
    output logic [6:0] display; // Outputs from 0 to 6 corresponding to bars on the 7 segment display

    assign display[0] = (~c[3]|c[0]) & (~c[2]|~c[1]) & (c[3]|~c[1]) & (c[3]|~c[2]|~c[0]) & (c[2]|c[0]) & (~c[3]|c[2]|c[1]);
	assign display[1] = (c[3]|c[2]) & (c[2]|c[0]) & (~c[3]|c[1]|~c[0]) & (c[3]|c[1]|c[0]) & (c[3]|~c[1]|~c[0]);
	assign display[2] = (c[3]&c[2]&c[1]) | (c[3]&c[2]&~c[0]) | (~c[3]&~c[2]&c[1]&~c[0]);
    assign display[3] = (c[2]&c[1]&c[0]) | (~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]&~c[0]) | (c[3]&~c[2]&c[1]&~c[0]);
	assign display[4] = (~c[2]&~c[1]&c[0]) | (~c[3]&c[2]&~c[1]) | (~c[3]&c[0]);
	assign display[5] = (~c[3]&~c[2]&c[0]) | (~c[3]&~c[2]&c[1]) | (~c[3]&c[1]&c[0]) | (c[3]&c[2]&~c[1]&c[0]);
	assign display[6] = (~c[3]&~c[2]&~c[1]) | (c[3]&c[2]&~c[1]&~c[0]) | (~c[3]&c[2]&c[1]&c[0]);
endmodule
