module customMemory(input [9:0] address, input readNot_write, inout [7:0] data);

    reg [7:0] ram [1023:0];
    reg [7:0] data_reg;

    assign data = (readNot_write) ? {8{1'bz}} : data_reg;

    always @(address or readNot_write or data) begin
        if (readNot_write) begin
            ram[address] = data;
        end else begin
            data_reg = ram[address]; 
        end
    end
endmodule
