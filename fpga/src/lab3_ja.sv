// Joseph Abdelmalek
// jabdelmalek@hmc.edu
// 9/23/24
// Top file for dual-segment display, HSOSC, keypad, and digit updater modules

module lab2_ja(
	input	logic	reset,
	input 	logic	[3:0] row, col,
	output	logic	d1, d2,
	output	logic	[6:0] seg
);

	logic clk;
	logic [3:0] n1, n2;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Call the modules	
	keyscanner 	keyscan3(.reset(reset), .clk(clk), .row(row), .col(col), .s(s));
	updatern	upd3(.reset(reset), .clk(clk), .s(s), .n1_in(n1), .n2_in(n2), .n1_out(n1), .n2_out(n2));
	mod_lab2	modlab3(.reset(reset), .clk(clk), .n1(n1), .n2(n2), .d1(d1), .d2(d2), .seg(seg));
	
endmodule