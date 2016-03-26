module magnitude(
	Y0, Y1, Y2, Y3, mag1, mag2);
	
	input [11:0] Y0, Y1, Y2, Y3;
	output [11:0] mag1, mag2;
	wire [11:0] max1, max2, min1, min2;
	wire [11:0] Z0, Z1, Z2, Z3;
	
	toPositive p1 (.in(Y0), .out(Z0));
	toPositive p2 (.in(Y1), .out(Z1));
	toPositive p3 (.in(Y2), .out(Z2));
	toPositive p4 (.in(Y3), .out(Z3));
	
	max m1 (.imagPart(Z1), .realPart(Z0), .maximun(max1));
	max m2 (.imagPart(Z3), .realPart(Z2), .maximun(max2));
	min m3 (.imagPart(Z1), .realPart(Z0), .minimum(min1));
	min m4 (.imagPart(Z3), .realPart(Z2), .minimum(min2));
	
	assign mag1 = max1 + (min1 >> 2) - (max1 >> 4);
	assign mag2 = max2 + (min2 >> 2) - (max2 >> 4);
	
endmodule

module toPositive(
	input [11:0] in,
	output reg [11:0] out);
	
	always @ * begin
		if(in[11] == 1'b1)
			out = ~in + 12'b1;
		else
			out = in;
	end
endmodule

module max(
	input [11:0] imagPart,
	input [11:0] realPart,
	output reg [11:0] maximun);
	
	always @ * begin
		if(imagPart > realPart)
			maximun = imagPart;
		else
			maximun = realPart;
	end
endmodule

module min(
	input [11:0] imagPart,
	input [11:0] realPart,
	output reg [11:0] minimum);
	
	always @ * begin
		if(imagPart > realPart)
			minimum = realPart;
		else
			minimum = imagPart;
	end
endmodule
		


