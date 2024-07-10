module testbench ();
localparam START_SIG = 1;

reg     rstN = 0, clk = 1, clk2 = 1;
reg     send_1, send_2;
reg     [6:0]   send_data_1, send_data_2;

wire    sent_1, sent_2;
wire    received_1, received_2;
wire    [6:0]   received_data_1, received_data_2;
wire    check_1, check_2;

uart #(START_SIG) U1 (rstN, clk, clk2, s_1, send_1, send_data_1, s_2, sent_1, received_1, received_data_1, check_1);
uart #(START_SIG) U2 (rstN, clk2, clk, s_2, send_2, send_data_2, s_1, sent_2, received_2, received_data_2, check_2);

always #10 clk = ~clk;
always #5 clk2 = ~clk2;

initial begin
    #40 rstN = 1;
end

wire [6:0]  string_1 [4:0];
assign string_1[4] = "E";
assign string_1[3] = "a";
assign string_1[2] = "g";
assign string_1[1] = "l";
assign string_1[0] = "e";
integer i;

initial begin
    #50;
    for (i = 5; i > 0; i = i - 1) begin
        send_data_1 = string_1[i-1];
        #10 send_1 = 1;
        #20 send_1 = 0;

        wait (sent_1);
        $display("%c sent from U1", send_data_1);
        wait (received_2);
        $display("%c received by U2. check: %d", received_data_2, check_2);
    end
    $stop();
end

wire [6:0]  string_2 [3:0];
assign string_2[3] = "W";
assign string_2[2] = "o";
assign string_2[1] = "l";
assign string_2[0] = "f";
integer j;

initial begin
    #90;
    for (j = 4; j > 0; j = j - 1) begin
        send_data_2 = string_2[j-1];
        #10 send_2 = 1;
        #20 send_2 = 0;

        wait (sent_2);
        $display("%c sent from U2", send_data_2);
        wait (received_1);
        $display("%c received by U1. check: %d", received_data_1, check_1);
    end
end

endmodule