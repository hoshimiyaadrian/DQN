module weight3(
 input clk,
 input [3:0] ctrl, sel,
 input signed [15:0] deltaw3_11, deltaw3_12, deltaw3_13, deltaw3_14,
 input signed [15:0] deltaw3_21, deltaw3_22, deltaw3_23, deltaw3_24,
 input signed [15:0] deltaw3_31, deltaw3_32, deltaw3_33, deltaw3_34,
 input signed [15:0] deltaw3_41, deltaw3_42, deltaw3_43, deltaw3_44,
 input signed [15:0] deltaw3_51, deltaw3_52, deltaw3_53, deltaw3_54,
 output signed [15:0] w3_1, w3_2, w3_3, w3_4
 );
 
 reg signed[15:0] w31[0:4];
 reg signed[15:0] w32[0:4];
 reg signed[15:0] w33[0:4];
 reg signed[15:0] w34[0:4];
 
 initial begin
	 $readmemh("w3_1.mif", w31);
	 $readmemh("w3_2.mif", w32);
	 $readmemh("w3_3.mif", w33);
	 $readmemh("w3_4.mif", w34);
 end
 
 always @(posedge clk) begin
   if (sel == 4'b1111) begin
     if (ctrl == 4'b1111) begin
		 w31[0] = deltaw3_11 + w31[0];
		 w31[1] = deltaw3_21 + w31[1];
		 w31[2] = deltaw3_31 + w31[2];
		 w31[3] = deltaw3_41 + w31[3];
		 w31[4] = deltaw3_51 + w31[4];
		 
		 w32[0] = deltaw3_12 + w32[0];
		 w32[1] = deltaw3_22 + w32[1];
		 w32[2] = deltaw3_32 + w32[2];
		 w32[3] = deltaw3_42 + w32[3];
		 w32[4] = deltaw3_52 + w32[4];
		 
		 w33[0] = deltaw3_13 + w33[0];
		 w33[1] = deltaw3_23 + w33[1];
		 w33[2] = deltaw3_33 + w33[2];
		 w33[3] = deltaw3_43 + w33[3];
		 w33[4] = deltaw3_53 + w33[4];
		 
		 w34[0] = deltaw3_13 + w34[0];
		 w34[1] = deltaw3_23 + w34[1];
		 w34[2] = deltaw3_33 + w34[2];
		 w34[3] = deltaw3_43 + w34[3];
		 w34[4] = deltaw3_53 + w34[4];
	  end
     
	  else begin
     end
   end
   
	else begin
   end
 end
 
assign w3_1 = w31[ctrl];
assign w3_2 = w32[ctrl];
assign w3_3 = w33[ctrl];
assign w3_4 = w34[ctrl];
 
endmodule
