library verilog;
use verilog.vl_types.all;
entity sender is
    generic(
        START_SIG       : integer := 1
    );
    port(
        rstN            : in     vl_logic;
        clk             : in     vl_logic;
        start           : in     vl_logic;
        data_in         : in     vl_logic_vector(6 downto 0);
        s_out           : out    vl_logic;
        sent            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of START_SIG : constant is 1;
end sender;
