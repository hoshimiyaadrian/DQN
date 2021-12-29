module fwd_prop(

 input clk, rst,
 input signed [15:0] deltaw2_11, deltaw2_12, deltaw2_13, deltaw2_14,
deltaw2_15,
 input signed [15:0] deltaw2_21, deltaw2_22, deltaw2_23, deltaw2_24,
deltaw2_25,
 input signed [15:0] deltaw2_31, deltaw2_32, deltaw2_33, deltaw2_34,
deltaw2_35,
 input signed [15:0] deltaw2_41, deltaw2_42, deltaw2_43, deltaw2_44,
deltaw2_45,
 input signed [15:0] deltaw2_51, deltaw2_52, deltaw2_53, deltaw2_54,
deltaw2_55,
 input signed [15:0] deltaw2_61, deltaw2_62, deltaw2_63, deltaw2_64,
deltaw2_65,
 input signed [15:0] deltaw2_71, deltaw2_72, deltaw2_73, deltaw2_74,
deltaw2_75,
 input signed [15:0] deltaw2_81, deltaw2_82, deltaw2_83, deltaw2_84,
deltaw2_85,
 input signed [15:0] deltaw2_91, deltaw2_92, deltaw2_93, deltaw2_94,
deltaw2_95,
 input signed [15:0] deltab2_1, deltab2_2, deltab2_3, deltab2_4, deltab2_5,
 input signed [15:0] deltaw3_11, deltaw3_12, deltaw3_13, deltaw3_14,
 input signed [15:0] deltaw3_21, deltaw3_22, deltaw3_23, deltaw3_24,
 input signed [15:0] deltaw3_31, deltaw3_32, deltaw3_33, deltaw3_34,
 input signed [15:0] deltaw3_41, deltaw3_42, deltaw3_43, deltaw3_44,
 input signed [15:0] deltaw3_51, deltaw3_52, deltaw3_53, deltaw3_54,
 input signed [15:0] deltab3_1, deltab3_2, deltab3_3, deltab3_4,
 
 input signed [15:0] in,
 input [3:0] ctrl, sel,
 
 output signed [15:0] a2_1out, a2_2out, a2_3out, a2_4out, a2_5out,
 output signed [15:0] w3_1out, w3_2out, w3_3out, w3_4out,
 output signed [15:0] a3_1out, a3_2out, a3_3out, a3_4out
 
 );
 
 wire signed [15:0] w2_1, w2_2, w2_3, w2_4, w2_5;
 wire signed [15:0] w3_1, w3_2, w3_3, w3_4;
 wire signed [31:0] bias2_1, bias2_2, bias2_3, bias2_4, bias2_5;
 wire signed [15:0] zout2_1, zout2_2, zout2_3, zout2_4, zout2_5;
 wire signed [15:0] a2_1, a2_2, a2_3, a2_4, a2_5;
 wire signed [15:0] a3_1, a3_2, a3_3, a4_4;
 wire signed [15:0] a;
 wire signed [31:0] bias3_1, bias3_2, bias3_3, bias3_4;
 wire signed [15:0] zout3_1, zout3_2, zout3_3, zout3_4;
 
//Weight2 Block
weight2 read_weight_2 (.clk(clk), .sel(sel), .ctrl(ctrl), .w2_1(w2_1), .w2_2(w2_2), .w2_3(w2_2), .w2_4(w2_3), .w2_5(w2_5),
 .deltaw2_11(deltaw2_11), .deltaw2_12(deltaw2_12), .deltaw2_13(deltaw2_13
), .deltaw2_14(deltaw2_14), .deltaw2_15(deltaw2_15),
 .deltaw2_21(deltaw2_21), .deltaw2_22(deltaw2_22), .deltaw2_23(deltaw2_23
), .deltaw2_24(deltaw2_24), .deltaw2_25(deltaw2_25),
 .deltaw2_31(deltaw2_31), .deltaw2_32(deltaw2_32), .deltaw2_33(deltaw2_33
), .deltaw2_34(deltaw2_34), .deltaw2_35(deltaw2_35),
 .deltaw2_41(deltaw2_41), .deltaw2_42(deltaw2_42), .deltaw2_43(deltaw2_43
), .deltaw2_44(deltaw2_44), .deltaw2_45(deltaw2_45),
 .deltaw2_51(deltaw2_51), .deltaw2_52(deltaw2_52), .deltaw2_53(deltaw2_53
), .deltaw2_54(deltaw2_54), .deltaw2_55(deltaw2_55),
 .deltaw2_61(deltaw2_61), .deltaw2_62(deltaw2_62), .deltaw2_63(deltaw2_63
), .deltaw2_64(deltaw2_64), .deltaw2_65(deltaw2_65),
 .deltaw2_71(deltaw2_71), .deltaw2_72(deltaw2_72), .deltaw2_73(deltaw2_73
), .deltaw2_74(deltaw2_74), .deltaw2_75(deltaw2_75),
 .deltaw2_81(deltaw2_81), .deltaw2_82(deltaw2_82), .deltaw2_83(deltaw2_83
), .deltaw2_84(deltaw2_84), .deltaw2_85(deltaw2_85),
 .deltaw2_91(deltaw2_91), .deltaw2_92(deltaw2_92), .deltaw2_93(deltaw2_93
), .deltaw2_94(deltaw2_94), .deltaw2_95(deltaw2_95));

//BIAS2 Block
bias2 BIAS2 (.clk(clk), .ctrl(ctrl), .sel(sel), .bias2_1(bias2_1), .bias2_2(bias2_2), .bias2_3(bias2_3), .bias2_4(bias2_4), .bias2_5(bias2_5), .deltab2_1(deltab2_1), .deltab2_2(deltab2_2), .deltab2_3(deltab2_3), .deltab2_4(deltab2_4), .deltab2_5(deltab2_5));

//Neural from Input to Hidden Layer
NN hn1 (.clk(clk), .ctrl(ctrl), .in(in), .w(w2_1), .rst(rst), .bias(bias2_1), .zout(zout2_1));
NN hn2 (.clk(clk), .ctrl(ctrl), .in(in), .w(w2_2), .rst(rst), .bias(bias2_2), .zout(zout2_2));
NN hn3 (.clk(clk), .ctrl(ctrl), .in(in), .w(w2_3), .rst(rst), .bias(bias2_3), .zout(zout2_3));
NN hn4 (.clk(clk), .ctrl(ctrl), .in(in), .w(w2_4), .rst(rst), .bias(bias2_4), .zout(zout2_4));
NN hn5 (.clk(clk), .ctrl(ctrl), .in(in), .w(w2_5), .rst(rst), .bias(bias2_5), .zout(zout2_5));

//Activation Function in Hidden Layers
activationFunction acf1 (.ctrl(ctrl), .z(zout2_1), .dout(a2_1));
activationFunction acf2 (.ctrl(ctrl), .z(zout2_2), .dout(a2_2));
activationFunction acf3 (.ctrl(ctrl), .z(zout2_3), .dout(a2_3));
activationFunction acf4 (.ctrl(ctrl), .z(zout2_4), .dout(a2_4));
activationFunction acf5 (.ctrl(ctrl), .z(zout2_5), .dout(a2_5));


//Weight 3 Block
weight3 read_weight_3
(.sel(sel), .clk(clk), .ctrl(ctrl), .w3_1(w3_1), .w3_2(w3_2), .w3_3(w3_3), .w3_4(w3_4),
 .deltaw3_11(deltaw3_11), .deltaw3_12(deltaw3_12), .deltaw3_13(deltaw3_13), .deltaw3_14(deltaw3_14),
 .deltaw3_21(deltaw3_21), .deltaw3_22(deltaw3_22), .deltaw3_23(deltaw3_23), .deltaw3_24(deltaw3_24),
 .deltaw3_31(deltaw3_31), .deltaw3_32(deltaw3_32), .deltaw3_33(deltaw3_33), .deltaw3_34(deltaw3_34),
 .deltaw3_41(deltaw3_41), .deltaw3_42(deltaw3_42), .deltaw3_43(deltaw3_43), .deltaw3_44(deltaw3_44),
 .deltaw3_51(deltaw3_51), .deltaw3_52(deltaw3_52), .deltaw3_53(deltaw3_53), .deltaw3_54(deltaw3_54));


//BIAS3 Block
bias3 BIAS3 (.clk(clk), .ctrl(ctrl), .sel(sel), .bias3_1(bias3_1), .bias3_2(bias3_2), .bias3_3(bias3_3), .bias3_4(bias3_4), .deltab3_1(deltab3_1), .deltab3_2(deltab3_2), .deltab3_3(deltab3_3), .deltab3_4(deltab3_4));

//PS Block
p2s_a p2s1 (.clk(clk), .rst(rst), .ctrl(ctrl), .sel(sel), .a2_1(a2_1), .a2_2(a2_2), .a2_3(a2_3), .a2_4(a2_4), .a2_5(a2_5), .a(a));


//Neural from Hidden Layers to Output Layers
NN hno1 (.clk(clk), .ctrl(ctrl), .in(a), .w(w3_1), .rst(rst), .bias(bias3_1), .zout(zout3_1));
NN hno2 (.clk(clk), .ctrl(ctrl), .in(a), .w(w3_2), .rst(rst), .bias(bias3_2), .zout(zout3_2));
NN hno3 (.clk(clk), .ctrl(ctrl), .in(a), .w(w3_3), .rst(rst), .bias(bias3_3), .zout(zout3_3));
NN hno4 (.clk(clk), .ctrl(ctrl), .in(a), .w(w3_4), .rst(rst), .bias(bias3_4), .zout(zout3_4));

//Activation Function in Output Layers
activationFunction acf_out_1 (.ctrl(ctrl), .z(zout3_1), .dout(a3_1));
activationFunction acf_out_2 (.ctrl(ctrl), .z(zout3_2), .dout(a3_2));
activationFunction acf_out_3 (.ctrl(ctrl), .z(zout3_3), .dout(a3_3));
activationFunction acf_out_4 (.ctrl(ctrl), .z(zout3_4), .dout(a3_4));

assign a2_1out = a2_1;
assign a2_2out = a2_2;
assign a2_3out = a2_3;
assign a2_4out = a2_4;
assign a2_5out = a2_5;

assign a3_1out = a3_1;
assign a3_2out = a3_2;
assign a3_3out = a3_3;
assign a3_4out = a3_4;

assign w3_1out = w3_1;
assign w3_2out = w3_2;
assign w3_3out = w3_3;
assign w3_4out = w3_4;

endmodule
