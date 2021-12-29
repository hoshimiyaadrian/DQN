module bias3 (input clk,
				  input [3:0] ctrl, sel,
				  input signed [15:0] deltab3_1, deltab3_2, deltab3_3, deltab3_4,
				  output signed [31:0] bias3_1, bias3_2, bias3_3, bias3_4);
 
 reg signed [31:0] bias3 [0:3];
 
 initial begin
   $readmemh("b3.mif", bias3);
 end
 
 always @(posedge clk) begin
   if (sel == 4'b1111) begin
	  if (ctrl == 4'b1111) begin
		 bias3[0] = bias3[0] + deltab3_1;
		 bias3[1] = bias3[1] + deltab3_2;
		 bias3[2] = bias3[2] + deltab3_3;
		 bias3[3] = bias3[3] + deltab3_4;
	  end
     else begin
	  end
   end
   
	else begin
   end
 end
 
 
 assign bias3_1 = bias3[0];
 assign bias3_2 = bias3[1];
 assign bias3_3 = bias3[2];
 assign bias3_4 = bias3[3];
 
endmodule
