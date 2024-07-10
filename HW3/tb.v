
module tb;
wire [9:0] p;
reg [3:0] a;
reg [5:0] x;

ArrayMultiplier am (p, a, x);
initial $monitor("a=%b, x=%b, p=%b", a, x, p);

initial begin

#10
a = 4'b1101;
x = 6'b011010;

#10
a = 4'b1110;
x = 6'b010010;

#10
a = 4'b0110;
x = 6'b010011;

#10
a = 4'b0011;
x = 6'b100011;

#10
a = 4'b1100;
x = 6'b000011;

#10
a = 4'b0000;
x = 6'b111101;

#10
a = 4'b0100;
x = 6'b001101;

#10
a = 4'b0100;
x = 6'b010001;

#10
a = 4'b0011;
x = 6'b011000;

#10
a = 4'b0010;
x = 6'b011010;

end
endmodule
