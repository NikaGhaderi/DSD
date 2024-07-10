library verilog;
use verilog.vl_types.all;
entity DoubleCell is
    port(
        Cnext           : out    vl_logic;
        Sthis           : out    vl_logic;
        xn              : in     vl_logic;
        am              : in     vl_logic;
        xn2             : in     vl_logic;
        am2             : in     vl_logic;
        Cthis           : in     vl_logic
    );
end DoubleCell;
