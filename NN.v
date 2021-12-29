module NN(clk, ctrl, in, w, rst, bias, zout);
 input clk, rst;
 input [3:0] ctrl;
 input signed[15:0] in, w;
 input signed[31:0] bias;
 output signed[15:0] zout;
 
 //wires and regs
 reg signed [32:0] z;
 
 always @(posedge clk)
 begin
   if (rst == 1'b1)
    begin
	  z <= bias;
    end
 
   else
    begin
     if (ctrl == 4'b1111)
      begin
       z = bias;
      end
    
	   else 
      begin
	    z = z + (w*in);
	    end
    end
 end
 
 assign zout = z[25:10];
 
endmodule
