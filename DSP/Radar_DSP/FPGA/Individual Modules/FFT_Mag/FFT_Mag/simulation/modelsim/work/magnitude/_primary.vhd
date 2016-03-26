library verilog;
use verilog.vl_types.all;
entity magnitude is
    port(
        clk             : in     vl_logic;
        Y0              : in     vl_logic_vector(11 downto 0);
        Y1              : in     vl_logic_vector(11 downto 0);
        Y2              : in     vl_logic_vector(11 downto 0);
        Y3              : in     vl_logic_vector(11 downto 0);
        mag1            : out    vl_logic_vector(11 downto 0);
        mag2            : out    vl_logic_vector(11 downto 0)
    );
end magnitude;
