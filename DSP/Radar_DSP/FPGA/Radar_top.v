//============================================================
//
//  Hsiang-Yi Chung
//  March 2016
//
//  This is the top level of the radar dsp module
//
//============================================================

module Radar_top(
	input clk,
	input reset_n,
	input [11:0] adc_in,
	output [11:0] mag_out1,
	output [11:0] mag_out2,
	output next_data,
	output data,
	output clk_div_16,

	//for debugging
	output fft_next_out,
	output [11:0] avg_out1,
	output [11:0] avg_out2,
	output [11:0] win_out1,
	output [11:0] win_out2,
	input fft_next,
	input fft_reset
);
	wire clk_div_32, win_next, reset_fft;
	
	clk_div clk_div_inst (.clk(clk), .clk_div_16(clk_div_16), .clk_div_32(clk_div_32));

	windowing window_inst(.in1(avg_out1), .in2(avg_out2), .clk(clk_div_16), 
			.out1(win_out1), .out2(win_out2), .next(win_next), .fft_reset(reset_fft));

	FFT_Mag fft_inst(.clk(clk_div_32), .reset(reset_fft), .next(win_next), 
			.X0(win_out1), .X1(0), .X2(win_out2), .X3(0),
			.mag1(mag_out1), .mag2(mag_out2), .next_out(fft_next_out));
	
	Average_Filter avg_filter_inst(.in(adc_in), .clk(clk), .reset_n(reset_n),
				.out1(avg_out1), .out2(avg_out2));
				
	SerialInterface serialInterface_inst(.clk(clk_div_16), .next_out(fft_next_out), .reset_n(reset_n), 
				.fft_out1(mag_out1), .fft_out2(mag_out2), .next_data(next_data), .data(data));
	
endmodule


