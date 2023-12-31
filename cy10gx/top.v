/* TOP module for cyclone 10 gx fpga 
 * PCS loopback */
module top #(
	parameter CNT_W = 25,
	parameter LED_W = 10
)(
    input  wire        OSC_50m,     // 50MHz
    input  wire        FPGA_RSTn,   //3.0V async reset in from BMC/RESET button
	/* led array */
	output wire [LED_W-1:0] USER_LED 

);

/* reset from IO, using asynchronous reset synchronizer circuit */
reg   io_meta_nreset_q;
reg   io_master_nreset_q;
logic io_master_nreset;

always @(posedge OSC_50m or negedge FPGA_RSTn) begin
	if (~FPGA_RSTn)begin
		io_meta_nreset_q   <= 1'b0;
		io_master_nreset_q <= 1'b0;
	end else begin
		io_meta_nreset_q   <= 1'b1;
		io_master_nreset_q <= io_meta_nreset_q;
	end
end
assign io_master_nreset = io_master_nreset_q;

reg   [CNT_W-1:0] cnt_q;
logic [CNT_W-1:0] cnt_next;
logic             cnt_of;

assign {cnt_of, cnt_next} = cnt_q + {{CNT_W-1{1'b0}}, 1'b1};
always @(posedge OSC_50m) begin
	if (~io_master_nreset)begin
		cnt_q <= {CNT_W{1'b0}};
	end else begin
		cnt_q <= cnt_next;
	end
end
/* led array blink */
logic [LED_W-1:0] led_next;
reg   [LED_W-1:0] led_q;
reg               dir_q;
logic             dir_next;

assign dir_next = dir_q & ~led_q[LED_W-1] | ~dir_q & led_q[0];
assign led_next = dir_q ? {led_q[LED_W-2:0], led_q[LED_W-1]} : {led_q[0], led_q[LED_W-1:1]};

always @(posedge OSC_50m) begin
	if (~io_master_nreset)begin
		led_q <= {{LED_W-1{1'b0}}, 1'b1};
		dir_q <= 1'b1;
	end else begin
		if ( cnt_of ) begin
		led_q = led_next;
		dir_q <= dir_next;
		end
	end
end

/* drive output led */
assign USER_LED = led_q;

endmodule
