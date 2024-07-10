library verilog;
use verilog.vl_types.all;
entity ArrayMultiplier is
    generic(
        m               : integer := 4;
        n               : integer := 6
    );
    port(
        product         : out    vl_logic_vector;
        a               : in     vl_logic_vector;
        x               : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of m : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
end ArrayMultiplier;
