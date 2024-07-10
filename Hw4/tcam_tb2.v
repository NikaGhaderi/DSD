module tcam_TB2;

reg             clk = 1, rstN = 0;
reg             we = 0;
reg             [2:0] waddr;
reg             [7:0] data;
reg             search = 0;
wire    [2:0]   saddr;
wire    [7:0]  sdata;
wire            found;

tcam #(8, 8) TCAM2(clk, rstN, we, waddr, data, search, saddr, sdata, found);

always #5 clk = ~clk;

initial
    begin

    #25 rstN = 1;
	#10 we = 1;

    waddr = 0;
    data = 8'bx1010101;
    
    #10;

    waddr = 1;
    data = 8'b010x0101;

    #10;

    waddr = 2;
	data = 8'b010x1x01;

    #10;

    waddr = 3;
	data = 8'b0101xxx1;

    #10;

    $display(" 0:%b\n 1:%b\n 2:%b\n 3:%b\n 4:%b\n 5:%b\n 6:%b\n 7:%b\n",
        TCAM2.mem[0],
        TCAM2.mem[1],
        TCAM2.mem[2],
        TCAM2.mem[3],
        TCAM2.mem[4],
        TCAM2.mem[5],
        TCAM2.mem[6],
        TCAM2.mem[7]);


    #10 we = 0;

    data = 8'b0101xx01;
    search = 1;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 8'b010xx101;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 8'b01111101;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);
    $stop;
    end
endmodule

