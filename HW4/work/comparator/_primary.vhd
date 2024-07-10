library verilog;
use verilog.vl_types.all;
entity comparator is
    generic(
        MEM_SIZE        : integer := 16;
        MEM_LENGTH      : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        match           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEM_SIZE : constant is 1;
    attribute mti_svvh_generic_type of MEM_LENGTH : constant is 1;
end comparator;
