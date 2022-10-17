module part1(a, b, c_in, s, c_out);
    input logic [3:0] a, b;
    input logic c_in;
    output logic [3:0] s, c_out; // c_out contains all the carry out bits from all 4 full adders

    full_adder fa1(a[0], b[0], c_in, s[0], c_out[0]);
    full_adder fa2(a[1], b[1], c_out[0], s[1], c_out[1]);
    full_adder fa2(a[2], b[2], c_out[1], s[2], c_out[2]);
    full_adder fa2(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule

module full_adder(a, b, c_in, s, c_out);
    input logic a, b, c_in;
    output logic s, c_out;

    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (a & c_in) | (c_in & b);
endmodule