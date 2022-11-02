module part2(A, B, Function, ALUout);
    input logic [3:0] a, b;
    output logic [7:0] ALUout;

    always_comb
    begin
        
    end

endmodule

module mux(x, y, s, f);
    input logic x, y, s;
    output logic f; 

    assign f = s ? y : x;
endmodule