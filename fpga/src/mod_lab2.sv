// Joseph Abdelmalek
// jabdelmalek@hmc.edu
// 9/23/24
// Modified Lab2 module to control dual display

module mod_lab2(
	input	logic	reset, clk,
	input 	logic	[3:0] n1, n2,
	output	logic	d1, d2,
	output	logic	[6:0] seg
);

	logic [3:0] s;
	
	// Call the modules	
	multiplex3	multi3(.reset(reset), .clk(clk), .n1(n1), .n2(n2), .d1(d1), .d2(d2), .s(s));
	seven_seg3 	seg3(.s(s), .seg(seg));
	
endmodule