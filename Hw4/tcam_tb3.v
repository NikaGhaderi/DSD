module tcam_TB3;

reg             clk = 1, rstN = 0;
reg             we = 0;
reg             [3:0] waddr;
reg             [16:0] data;
reg             search = 0;
wire    [3:0]   saddr;
wire    [16:0]  sdata;
wire            found;

tcam #(10, 17) TCAM3(clk, rstN, we, waddr, data, search, saddr, sdata, found);

always #5 clk = ~clk;

initial
    begin

    #25 rstN = 1;
	#10 we = 1;

    waddr = 0;
    data = 17'b00x01010100000111;
    
    #10;

    waddr = 5;
    data = 17'b00x01x1110xxxx000;

    #10;

    waddr = 9;
	data = 17'b00x010x0100100100;

    #10;

    waddr = 6;
	data = 17'b11x010x010000x00x;

    #10;
    
    waddr = 2;
	data = 17'b0000000010000x00x;

    #10;

    waddr = 1;
	data = 17'b11111100100000000;

    #10;
    $display(" 0:%b\n 1:%b\n 2:%b\n 3:%b\n 4:%b\n 5:%b\n 6:%b\n 7:%b\n 8:%b\n 9:%b\n",
        TCAM3.mem[0],
        TCAM3.mem[1],
        TCAM3.mem[2],
        TCAM3.mem[3],
        TCAM3.mem[4],
        TCAM3.mem[5],
        TCAM3.mem[6],
        TCAM3.mem[7],
        TCAM3.mem[8],
        TCAM3.mem[9],
        );


    #10 we = 0;

    data = 17'b11111100100000000;
    search = 1;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 17'b1100101010xx01001;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 17'b10x01010100000111;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 17'b0x10xx11101010000;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    #10;
    $stop;
    end
endmodule


