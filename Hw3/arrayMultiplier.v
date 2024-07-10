
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

parameter m = 4;
parameter n = 6;
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

             
DoubleCell c_first0(.Cnext(c_partial[0]), .Sthis(s_partial[0]),
    .xn(x[0]), .am(a[1]), .xn2(x[1]), .am2(a[0]), .Cthis(1'b0));

             
DoubleCell c_first1(.Cnext(c_partial[1]), .Sthis(s_partial[1]),
    .xn(x[0]), .am(a[2]), .xn2(x[1]), .am2(a[1]), .Cthis(1'b0));

             
DoubleCell c_first2(.Cnext(c_partial[2]), .Sthis(s_partial[2]),
    .xn(x[0]), .am(a[3]), .xn2(x[1]), .am2(a[2]), .Cthis(1'b0));

  

// middle lines except for the last columns in each row:
  

          
Cell c_middle00(c_partial[3], s_partial[3],
    a[0], x[2], s_partial[1], c_partial[0]);

          
Cell c_middle01(c_partial[4], s_partial[4],
    a[1], x[2], s_partial[2], c_partial[1]);

          
Cell c_middle10(c_partial[6], s_partial[6],
    a[0], x[3], s_partial[4], c_partial[3]);

          
Cell c_middle11(c_partial[7], s_partial[7],
    a[1], x[3], s_partial[5], c_partial[4]);

          
Cell c_middle20(c_partial[9], s_partial[9],
    a[0], x[4], s_partial[7], c_partial[6]);

          
Cell c_middle21(c_partial[10], s_partial[10],
    a[1], x[4], s_partial[8], c_partial[7]);

          
Cell c_middle30(c_partial[12], s_partial[12],
    a[0], x[5], s_partial[10], c_partial[9]);

          
Cell c_middle31(c_partial[13], s_partial[13],
    a[1], x[5], s_partial[11], c_partial[10]);



// last columns except for the last row



DoubleCell c_last0(c_partial[5], s_partial[5],
    a[2], x[2], a[3], x[1], c_partial[2]);


DoubleCell c_last1(c_partial[8], s_partial[8],
    a[2], x[3], a[3], x[2], c_partial[5]);


DoubleCell c_last2(c_partial[11], s_partial[11],
    a[2], x[4], a[3], x[3], c_partial[8]);


DoubleCell c_last3(c_partial[14], s_partial[14],
    a[2], x[5], a[3], x[4], c_partial[11]);



// first column of the last row
Cell c_result(c_partial[15], s_partial[15],
    1'b0, 1'b0, s_partial[13], c_partial[12]);

// last row exept for the last and first columns


    
Cell c_result1(c_partial[16], s_partial[16],
    1'b1, c_partial[15], s_partial[14], c_partial[13]);



// last column of the last row
Cell c_result_ll(c_partial[17], s_partial[17],
    a[3], x[5], c_partial[16], c_partial[14]);


// product bits from first and middle cells
 


buf (product[1], s_partial[0]);


buf (product[2], s_partial[3]);


buf (product[3], s_partial[6]);


buf (product[4], s_partial[9]);


buf (product[5], s_partial[12]);



// product bits from the last line of cells



buf (product[6], s_partial[15]); 

buf (product[7], s_partial[16]); 

buf (product[8], s_partial[17]); 

// msb and lsb of product
buf (product[9], c_partial[17]);
buf (product[0], p0);

endmodule
