library verilog;
use verilog.vl_types.all;
entity dft_top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \next\          : in     vl_logic;
        next_out        : out    vl_logic;
        X0              : in     vl_logic_vector(11 downto 0);
        Y0              : out    vl_logic_vector(11 downto 0);
        X1              : in     vl_logic_vector(11 downto 0);
        Y1              : out    vl_logic_vector(11 downto 0);
        X2              : in     vl_logic_vector(11 downto 0);
        Y2              : out    vl_logic_vector(11 downto 0);
        X3              : in     vl_logic_vector(11 downto 0);
        Y3              : out    vl_logic_vector(11 downto 0)
    );
end dft_top;
