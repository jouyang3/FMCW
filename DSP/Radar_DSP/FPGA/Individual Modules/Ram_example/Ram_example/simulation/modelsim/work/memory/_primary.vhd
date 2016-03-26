library verilog;
use verilog.vl_types.all;
entity memory is
    port(
        addr_a          : in     vl_logic_vector(10 downto 0);
        addr_b          : in     vl_logic_vector(10 downto 0);
        clk             : in     vl_logic;
        q_a             : out    vl_logic_vector(7 downto 0);
        q_b             : out    vl_logic_vector(7 downto 0)
    );
end memory;
