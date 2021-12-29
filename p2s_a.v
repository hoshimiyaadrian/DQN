module p2s_a (clk, rst, sel, ctrl, a2_1, a2_2, a2_3, a2_4, a2_5,
a);
 
 input clk, rst;
 input [3:0] ctrl, sel;
 input signed [15:0] a2_1, a2_2, a2_3, a2_4, a2_5;
 output signed [15:0] a;
 
 //wires and regs
 reg signed [15:0] amem[0:4];
 
 always @(posedge clk) begin
   if (rst == 1'b1) begin
	 amem[0] = 1'b0;
	 amem[1] = 1'b0;
	 amem[2] = 1'b0;
	 amem[3] = 1'b0;
	 amem[4] = 1'b0;
   end
   
	else begin
    if (sel != 4'b0000) begin
     if (ctrl == 4'b1000) begin
		 amem[0] = a2_1;
		 amem[1] = a2_2;
		 amem[2] = a2_3;
		 amem[3] = a2_4;
		 amem[4] = a2_5;
     end
    end
   end
 end
 
 assign a = amem[ctrl-(4'b1001)];
 
 endmodule
