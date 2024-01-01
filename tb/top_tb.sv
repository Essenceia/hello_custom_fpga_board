module top_tb;

localparam LED_W = 8;
localparam CNT_W = 1;

logic nreset; 
reg clk = 1'b1;

always clk = #5 ~clk;

logic [LED_W-1:0] led;

initial begin
	$dumpfile("wave/top_tb.vcd");
	$dumpvars(0,top_tb);
	nreset = 1'b0;
	#10
	nreset = 1'b1;
	#100;

	$finish;	
end
top#(
	.CNT_W(CNT_W),
	.LED_W(LED_W)
)m_top(
    .OSC_50m(clk),
    .FPGA_RSTn(nreset),
	.USER_LED(led) 

);
endmodule
