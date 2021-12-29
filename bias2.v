module bias2 (input clk,
				  input [3:0] ctrl, sel,
				  input signed [15:0] deltab2_1, deltab2_2, deltab2_3, deltab2_4, deltab2_5,
				  output signed [31:0] bias2_1, bias2_2, bias2_3, bias2_4, bias2_5);
 
 reg signed [31:0] bias2 [0:4];
 
 initial begin
   $readmemh("b2.mif", bias2);
 end
 
 always @(posedge clk) begin
   if (sel == 4'b1111) begin
	  if (ctrl == 4'b1111) begin
		 bias2[0] = bias2[0] + deltab2_1;
		 bias2[1] = bias2[1] + deltab2_2;
		 bias2[2] = bias2[2] + deltab2_3;
		 bias2[3] = bias2[3] + deltab2_4;
		 bias2[4] = bias2[4] + deltab2_5;
	  end
     else begin
	  end
   end
   
	else begin
   end
 end
 
 
 assign bias2_1 = bias2[0];
 assign bias2_2 = bias2[1];
 assign bias2_3 = bias2[2];
 assign bias2_4 = bias2[3];
 assign bias2_5 = bias2[4];
 
endmodule
