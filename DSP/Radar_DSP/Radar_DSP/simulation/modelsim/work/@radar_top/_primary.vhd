library verilog;
use verilog.vl_types.all;
entity Radar_top is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        adc_in          : in     vl_logic_vector(11 downto 0);
        mag_out1        : out    vl_logic_vector(11 downto 0);
        mag_out2        : out    vl_logic_vector(11 downto 0);
        next_data       : out    vl_logic;
        data            : out    vl_logic;
        clk_div_16      : out    vl_logic;
        fft_next_out    : out    vl_logic;
        avg_out1        : out    vl_logic_vector(11 downto 0);
        avg_out2        : out    vl_logic_vector(11 downto 0);
        win_out1        : out    vl_logic_vector(11 downto 0);
        win_out2        : out    vl_logic_vector(11 downto 0);
        fft_next        : in     vl_logic;
        fft_reset       : in     vl_logic
    );
end Radar_top;
