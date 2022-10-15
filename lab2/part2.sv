`timescale 1ns / 1ns // `timescale time_unit/time_precision

// Define mux2to1 module
module mux2to1(x, y, s, m);
    input logic x, y, s;
    output logic m;

    logic wire1, wire2, wire3;

    v7404 u0(.pin1(s), .pin2(wire1));                                                   // Invert s signal
    v7408 u1(.pin1(wire1), .pin2(x), .pin3(wire2), .pin4(s), .pin5(y), .pin6(wire3));   // (~s & x) to wire 2, (s & y) to wire 3
    v7432 u2(.pin1(wire2), .pin2(wire3), .pin3(m));                                     // Put everything together: m = (~s & x) | (s & y)
endmodule


// Define chips
module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
    input logic pin1, pin3, pin5, pin9, pin11, pin13;
    output logic pin2, pin4, pin6, pin8, pin10, pin12;

	// Invert all input pins for output
    assign pin2 = ~pin1;
    assign pin4 = ~pin3;
    assign pin6 = ~pin5;
    assign pin8 = ~pin9;
    assign pin10 = ~pin11;
    assign pin12 = ~pin13;
endmodule


module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
    input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
    output logic pin3, pin6, pin8, pin11;

	// AND together input pins for output
    assign pin3 = pin1 & pin2;
    assign pin6 = pin4 & pin5;
    assign pin8 = pin9 & pin10;
    assign pin11 = pin12 & pin13;
endmodule


module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
    input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
    output logic pin3, pin6, pin8, pin11;

	// OR input pins for output
    assign pin3 = pin1 | pin2;
    assign pin6 = pin4 | pin5;
    assign pin8 = pin9 | pin10;
    assign pin11 = pin12 | pin13;
endmodule