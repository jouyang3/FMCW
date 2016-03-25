library verilog;
use verilog.vl_types.all;
entity Average_Filter is
    port(
        \in\            : in     vl_logic_vector(11 downto 0);
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        out_ready       : out    vl_logic;
        out1            : out    vl_logic_vector(11 downto 0);
        out2            : out    vl_logic_vector(11 downto 0)
    );
end Average_Filter;
