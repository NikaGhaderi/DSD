module tb;
    reg clk;
    reg readNot_write;
    reg [9:0] address;
    wire [7:0] data;
    reg [7:0] tb_data;

    // Instantiate the RAM module
    customMemory uut(
        .address(address),
        .readNot_write(readNot_write),
        .data(data)
    );

    assign data = (readNot_write) ? tb_data : {8{1'bz}};

    initial begin
        $display("reading from an unknown address (uninitialized):");
        clk = 0;
        tb_data = 8'h56;
        readNot_write = 0;
        address = 55;

        #20;
        // Write operation
        $display("writing to an address (55):");
        readNot_write = 1;
        #20;

        // Read from an address which we don't know its contents
        $display("reading from an unknown address (uninitialized):");
        readNot_write = 0;
        address = 66;
        tb_data = 8'h36;
        #20;

        // Write into address 66
         $display("writing to an address (66):");
        readNot_write = 1;
        #20;

        // Read the value we just wrote into address 66
        $display("reading from the previous address (66):");
        readNot_write = 0;
        #20;
        
        // Read the value we set in address 55
        $display("reading from the first address (55):");
        address = 55;
        #20;
        
        $display("reading from 66 again:");
        address = 66;

        #20 $stop;
    end

    always #10 clk = ~clk; // Generate clock signal
    initial $monitor("readNot_write=%b, address=%b, data=%b", readNot_write, address, data);

endmodule


