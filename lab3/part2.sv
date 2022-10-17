module part2(A, B, Function, ALUout);
endmodule

module mux(x, y, s, f);
    input logic x, y, s;
    output logic f; 

    assign f = s ? y : x;
endmodule