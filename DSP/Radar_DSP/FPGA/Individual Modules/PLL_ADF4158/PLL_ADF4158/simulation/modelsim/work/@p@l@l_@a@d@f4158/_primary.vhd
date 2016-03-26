library verilog;
use verilog.vl_types.all;
entity PLL_ADF4158 is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        writeData       : out    vl_logic;
        loadEnable      : out    vl_logic;
        pll_clk         : out    vl_logic
    );
end PLL_ADF4158;
