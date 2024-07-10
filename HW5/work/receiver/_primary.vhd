library verilog;
use verilog.vl_types.all;
entity receiver is
    generic(
        START_SIG       : integer := 1
    );
    port(
        rstN            : in     vl_logic;
        clk             : in     vl_logic;
        s_in            : in     vl_logic;
        received        : out    vl_logic;
        check_parity    : out    vl_logic;
        data            : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of START_SIG : constant is 1;
end receiver;
