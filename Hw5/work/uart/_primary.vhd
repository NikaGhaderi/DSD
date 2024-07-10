library verilog;
use verilog.vl_types.all;
entity uart is
    generic(
        START_SIG       : integer := 1
    );
    port(
        rstN            : in     vl_logic;
        clk             : in     vl_logic;
        clk2            : in     vl_logic;
        s_in            : in     vl_logic;
        send            : in     vl_logic;
        send_data       : in     vl_logic_vector(6 downto 0);
        s_out           : out    vl_logic;
        sent            : out    vl_logic;
        received        : out    vl_logic;
        received_data   : out    vl_logic_vector(6 downto 0);
        check_receive_parity: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of START_SIG : constant is 1;
end uart;
