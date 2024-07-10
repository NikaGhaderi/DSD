library verilog;
use verilog.vl_types.all;
entity tcam is
    generic(
        MEM_SIZE        : integer := 16;
        MEM_LENGTH      : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rstN            : in     vl_logic;
        we              : in     vl_logic;
        waddr           : in     vl_logic_vector;
        data            : in     vl_logic_vector;
        search          : in     vl_logic;
        saddr           : out    vl_logic_vector;
        sdata           : out    vl_logic_vector;
        found           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEM_SIZE : constant is 1;
    attribute mti_svvh_generic_type of MEM_LENGTH : constant is 1;
end tcam;
