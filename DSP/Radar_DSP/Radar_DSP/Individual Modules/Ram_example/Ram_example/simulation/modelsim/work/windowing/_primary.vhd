library verilog;
use verilog.vl_types.all;
entity windowing is
    port(
        in1             : in     vl_logic_vector(11 downto 0);
        in2             : in     vl_logic_vector(11 downto 0);
        clk             : in     vl_logic;
        out1            : out    vl_logic_vector(11 downto 0);
        out2            : out    vl_logic_vector(11 downto 0);
        \next\          : out    vl_logic;
        state           : out    vl_logic_vector(2 downto 0)
    );
end windowing;
