import random


def generate_array_multiplier(n, m):
    # Validate input: Ensure n and m are positive integers
    if not (isinstance(n, int) and isinstance(m, int) and n > 0 and m > 0):
        print("Invalid input. Please provide positive integer values for n and m.")
        return

    # Generate Verilog code for the array multiplier
    verilog_code = f"""
module DoubleCell(output Cnext, Sthis, input xn, am, xn2, am2, Cthis);
  
  wire t1, t2, t3, t4, t5;
  and (t1, am, xn);
  and (t2, am2, xn2);

  xor (Sthis, t1, t2, Cthis);
  xor (t3, t2, Cthis);
  and (t4, t1, t3);
  and (t5, Cthis, t2);
  or (Cnext, t4, t5);

endmodule


module Cell(output Cnext, Sthis, input xn, am, Slast, Cthis);

  wire t;
  and (t, xn, am);

  xor (Sthis, t, Slast, Cthis);
  xor (t1, Slast, Cthis);
  and (t2, t, t1);
  and (t3, Cthis, Slast);
  or (Cnext, t2, t3);
  
endmodule


module ArrayMultiplier(product, a, x);
  
// a => m bit
// b => n bit (x)

parameter m = {m};
parameter n = {n};
output [m+n-1:0] product;
input [m-1:0] a;
input [n-1:0] x;

wire c_partial[(m-1)*n-1:0] ;
wire s_partial[(m-1)*n-1:0] ;
wire p0;
wire c0;

Cell p_first(.Cnext(c0), .Sthis(p0),
                   .xn(x[0]), .am(a[0]), .Slast(1'b0), .Cthis(1'b0));
                   
                   
// first line of the multiplier:
"""
    for i in range(m - 1):
        verilog_code += f"""
             
DoubleCell c_first{i}(.Cnext(c_partial[{i}]), .Sthis(s_partial[{i}]),
    .xn(x[0]), .am(a[{i + 1}]), .xn2(x[1]), .am2(a[{i}]), .Cthis(1'b0));
"""
    verilog_code += f"""
  

// middle lines except for the last columns in each row:
  
"""
    for j in range(n - 2):
        for k in range(m - 2):
            verilog_code += f"""
          
Cell c_middle{j}{k}(c_partial[{(m - 1) * (j + 1) + k}], s_partial[{(m - 1) * (j + 1) + k}],
    a[{k}], x[{j + 2}], s_partial[{(m - 1) * j + k + 1}], c_partial[{(m - 1) * j + k}]);
"""
    verilog_code += f"""


// last columns except for the last row

"""
    for z in range(n - 2):
        verilog_code += f"""

DoubleCell c_last{z}(c_partial[{(m - 1) * (z + 1) + m - 2}], s_partial[{(m - 1) * (z + 1) + m - 2}],
    a[{m - 2}], x[{z + 2}], a[{m - 1}], x[{z + 1}], c_partial[{(m - 1) * (z) + m - 2}]);
"""
    verilog_code += f"""


// first column of the last row
Cell c_result(c_partial[{(m - 1) * (n - 1)}], s_partial[{(m - 1) * (n - 1)}],
    1'b0, 1'b0, s_partial[{(m - 1) * (n - 2) + 1}], c_partial[{(m - 1) * (n - 2)}]);

// last row exept for the last and first columns

"""

    for l in range(1, m - 2):
        verilog_code += f"""
    
Cell c_result{l}(c_partial[{(m - 1) * (n - 1) + l}], s_partial[{(m - 1) * (n - 1) + l}],
    1'b1, c_partial[{(m - 1) * (n - 1) + l - 1}], s_partial[{(m - 1) * (n - 2) + l + 1}], c_partial[{(m - 1) * (n - 2) + l}]);
"""

    verilog_code += f"""


// last column of the last row
Cell c_result_ll(c_partial[{(m - 1) * (n - 1) + m - 2}], s_partial[{(m - 1) * (n - 1) + m - 2}],
    a[{m - 1}], x[{n - 1}], c_partial[{(m - 1) * (n - 1) + m - 3}], c_partial[{(m - 1) * (n - 2) + m - 2}]);


// product bits from first and middle cells
 
"""
    for i in range(n - 1):
        verilog_code += f"""

buf (product[{i + 1}], s_partial[{(m - 1) * i}]);
"""
    verilog_code += f"""


// product bits from the last line of cells

"""

    for i in range(n - 1, n + m - 2):
        verilog_code += f"""

buf (product[{i + 1}], s_partial[{(m - 1) * (n - 1) + i - (n - 1)}]); """

    verilog_code += f"""

// msb and lsb of product
buf (product[{m + n - 1}], c_partial[{(m - 1) * (n - 1) + m - 2}]);
buf (product[0], p0);

endmodule
"""

    # Write the Verilog code to a file
    with open("arrayMultiplier.v", "w") as f:
        f.write(verilog_code)

    print("Verilog code written to arrayMultiplier.v successfully!")

    prmt = input("Would you like to get a testbench as well? enter y for yes, n for no.\n")
    if prmt.strip() == 'y':
        testbench_code = f"""
module tb;
wire [{n+m-1}:0] p;
reg [{m-1}:0] a;
reg [{n-1}:0] x;

ArrayMultiplier am (p, a, x);
initial $monitor("a=%b, x=%b, p=%b", a, x, p);

initial begin
"""
        for i in range(10):
            a_generated = "".join(str(random.randint(0, 1)) for _ in range(m))
            x_generated = "".join(str(random.randint(0, 1)) for _ in range(n))
            testbench_code += f"""
#10
a = {m}'b{a_generated};
x = {n}'b{x_generated};
"""

        testbench_code += """
end
endmodule
"""
        with open("tb.v", "w") as f:
            f.write(testbench_code)
        print(f"""process finished: multiplier code generated for m = {m} and n = {n} and testbench created""")
    else:
        print(f"""process finished: multiplier code generated for m = {m} and n = {n}""")


if __name__ == "__main__":
    try:
        m = int(input("Enter the number of bits for a - first number with 'm' bits: "))
        n = int(input("Enter the number of bits for x - second number with 'n' bits: "))
        generate_array_multiplier(n, m)
    except ValueError:
        print("Invalid input. Please provide valid integer values for n and m.")