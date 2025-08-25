module full_adder (
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);
always_comb
begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (cin & (a ^ b));
end
endmodule