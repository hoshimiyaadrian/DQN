module activationFunction(clk, rst, ctrl, z, dout);
 input clk;
 input rst;
 input [3:0] ctrl;
 input signed [15:0] z;
 output signed [15:0] dout;
 
 //wires and regs
 reg [15:0] a1;
 
 always @(posedge clk) begin
  if (rst == 1'b1) begin
    a1 <= 16'd0;
  end
  
  else
  begin
    if (ctrl == 4'b0011)
      begin
        if (z[15] == 1'b1) //for negative z
          begin
            if ((-z) > 16'b000101_0000000000) //-z > 5
            begin
              a1 <= 16'd0; //a1 = 0
            end
            else if (((-z) > 16'b000010_0110000000) && ((-z) < 16'b000101_0000000000)) //if (-z > 2.375) and (-z < 5)
              a1 <= ((z >> 5) + 16'b000000_0010100000);                                //a1 = (z/32 + 0.15625);
            else if (((-z) > 16'b000001_0000000000) && ((-z) < 16'b000010_0110000000)) //if (-z > 1) and (-z < 2.375)
              a1 <= ((z >> 3) + 16'b000000_0110000000);                                //a1 = (z/8 + 0.375);
            else
              a1 <= ((z >> 2) + 16'b000000_1000000000);                               //a1 = (z/4 + 0.5);
          end
        else if (z[15] == 1'b0) //for positive z
          begin
            if (z > 16'b000101_0000000000) //z > 5
              a1 <= 16'b000001_0000000000; //a1 = 1
            else if ((z > 16'b000010_0110000000) && (z < 16'b000101_0000000000)) //if (z > 2.375) and (z < 5)
              a1 <= (z>>5) + 16'b000000_1101100000;                              //a1 = z/32 + 0.84375
            else if ((z > 16'b000001_0000000000) && (z < 16'b000010_0110000000)) //if (z > 1) and (z < 2.375)
              a1 <= (z>>3) + 16'b000000_1010000000;                              //a1 = z/8 + 0.625
            else
              a1 <= (z>>2) + 16'b000000_1000000000;                              //a1 = z/4 + 0.5
          end
        else
          begin
            a1 <= a1;
          end
      end

    else
      begin
        a1 <= a1;
      end
  end
 end

assign dout = a1;

endmodule
