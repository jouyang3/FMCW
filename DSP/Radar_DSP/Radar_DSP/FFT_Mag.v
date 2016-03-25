//=======================================================================
//
//  Hsiang-Yi Chung
//  March 2016
//
//  This Module combines fft module and magnitude module.
//  It takes in a time signal and outputs the magnitude of frequency spectrum.
//
//=======================================================================

module FFT_Mag(
	input clk,
	input reset,
	input next,
	input [11:0] X0,
	input [11:0] X1,
	input [11:0] X2,
	input [11:0] X3,
	output [11:0] mag1,
	output [11:0] mag2,
	output next_out,
	output [11:0] Y0,
	output [11:0] Y1,
	output [11:0] Y2,
	output [11:0] Y3
	
	);
	
   dft_top dft_top_instance (.clk(clk), .reset(reset), .next(next), .next_out(next_out),
    .X0(X0), .Y0(Y0),
    .X1(X1), .Y1(Y1),
    .X2(X2), .Y2(Y2),
    .X3(X3), .Y3(Y3));

	magnitude magnitude_inst(.Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3), .mag1(mag1), .mag2(mag2));
	 
	 
endmodule
