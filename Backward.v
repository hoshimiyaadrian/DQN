module Backward (
//input    
    clk, rst, 
    
    //control
    step, controller,

    //a3
    a3_0, a3_1, a3_2, a3_3,

    //a2
    a2_0, a2_1, a2_2, a2_3, a2_4,
    
    //weight hidden-output layer
    w3_0_0, w3_0_1, w3_0_2, w3_0_3, w3_0_4, 
    w3_1_0, w3_1_1, w3_1_2, w3_1_3, w3_1_4, 
    w3_2_0, w3_2_1, w3_2_2, w3_2_3, w3_2_4,
    w3_3_0, w3_3_1, w3_3_2, w3_3_3, w3_3_4,
    
    //data_in
    data_in,

//output
    //delta w3
    deltaw3_0_0, deltaw3_0_1, deltaw3_0_2, deltaw3_0_3, deltaw3_0_4,
    deltaw3_1_0, deltaw3_1_1, deltaw3_1_2, deltaw3_1_3, deltaw3_1_4,
    deltaw3_2_0, deltaw3_2_1, deltaw3_2_2, deltaw3_2_3, deltaw3_2_4,
    deltaw3_3_0, deltaw3_3_1, deltaw3_3_2, deltaw3_3_3, deltaw3_3_4,

    //delta w2
    deltaw2_0_0, deltaw2_0_1, deltaw2_0_2, deltaw2_0_3, deltaw2_0_4, 
    deltaw2_0_5, deltaw2_0_6, deltaw2_0_7, deltaw2_0_8,
    deltaw2_1_0, deltaw2_1_1, deltaw2_1_2, deltaw2_1_3, deltaw2_1_4, 
    deltaw2_1_5, deltaw2_1_6, deltaw2_1_7, deltaw2_1_8,
    deltaw2_2_0, deltaw2_2_1, deltaw2_2_2, deltaw2_2_3, deltaw2_2_4, 
    deltaw2_2_5, deltaw2_2_6, deltaw2_2_7, deltaw2_2_8,
    deltaw2_3_0, deltaw2_3_1, deltaw2_3_2, deltaw2_3_3, deltaw2_3_4, 
    deltaw2_3_5, deltaw2_3_6, deltaw2_3_7, deltaw2_3_8,
    deltaw2_4_0, deltaw2_4_1, deltaw2_4_2, deltaw2_4_3, deltaw2_4_4, 
    deltaw2_4_5, deltaw2_4_6, deltaw2_4_7, deltaw2_4_8,

    //delta b3
    deltab3_0, deltab3_1, deltab3_2, deltab3_3,

    //delta b2
    deltab2_0, deltab2_1, deltab2_2, deltab2_3, deltab2_4
);

    input clk, rst;
    input [3:0] step, controller;
    input signed [15:0] a3_0, a3_1, a3_2, a3_3;
    input signed [15:0] a2_0, a2_1, a2_2, a2_3, a2_4;
    input signed [15:0] t_1, t_2, t_3;
    input signed [15:0] w3_0_0, w3_0_1, w3_0_2, w3_0_3, w3_0_4, 
                        w3_1_0, w3_1_1, w3_1_2, w3_1_3, w3_1_4,
                        w3_2_0, w3_2_1, w3_2_2, w3_2_3, w3_2_4,
                        w3_3_0, w3_3_1, w3_3_2, w3_3_3, w3_3_4;
    input signed [15:0] data_in;
    output signed [15:0] deltaw3_0_0, deltaw3_0_1, deltaw3_0_2, deltaw3_0_3, deltaw3_0_4,
                        deltaw3_1_0, deltaw3_1_1, deltaw3_1_2, deltaw3_1_3, deltaw3_1_4,
                        deltaw3_2_0, deltaw3_2_1, deltaw3_2_2, deltaw3_2_3, deltaw3_2_4,
                        deltaw3_3_0, deltaw3_3_1, deltaw3_3_2, deltaw3_3_3, deltaw3_3_4;
    output signed [15:0] deltaw2_0_0, deltaw2_0_1, deltaw2_0_2, deltaw2_0_3, deltaw2_0_4, 
                        deltaw2_0_5, deltaw2_0_6, deltaw2_0_7, deltaw2_0_8,
                        deltaw2_1_0, deltaw2_1_1, deltaw2_1_2, deltaw2_1_3, deltaw2_1_4, 
                        deltaw2_1_5, deltaw2_1_6, deltaw2_1_7, deltaw2_1_8,
                        deltaw2_2_0, deltaw2_2_1, deltaw2_2_2, deltaw2_2_3, deltaw2_2_4, 
                        deltaw2_2_5, deltaw2_2_6, deltaw2_2_7, deltaw2_2_8,
                        deltaw2_3_0, deltaw2_3_1, deltaw2_3_2, deltaw2_3_3, deltaw2_3_4, 
                        deltaw2_3_5, deltaw2_3_6, deltaw2_3_7, deltaw2_3_8,
                        deltaw2_4_0, deltaw2_4_1, deltaw2_4_2, deltaw2_4_3, deltaw2_4_4, 
                        deltaw2_4_5, deltaw2_4_6, deltaw2_4_7, deltaw2_4_8;
    output signed [15:0] deltab3_0, deltab3_1, deltab3_2, deltab3_3;
    output signed [15:0] deltab2_0, deltab2_1, deltab2_2, deltab2_3, deltab2_4;

endmodule

//dadz is a module that generates differential of activation function
//dadz = (1-a)*a where a is sigmoid function
module dadz_module (
    clk, rst, a, step, controller, dadz
);
    input  clk, rst;
    input signed [15:0] a;
    input [3:0] step, controller;
    output signed [15:0] dadz;

    reg signed [31:0] temp;
    parameter [15:0] one_representation = 16'b000001_0000000000;

    always @(posedge clk ) begin
        if(rst) begin
            temp = 31'd0;
        end
        else begin
            if(step != 4'd0) begin
                if(controller == 4'd6) begin //need to check timing diagram again
                    temp = (one_representation - a) * a;
                end
                else temp = temp;
            end
            else temp = temp;
        end
    end

    assign  dadz = temp[25:10];
endmodule

////////////////////////////////////////////////////

//delta3 is a module that generates error of output hidden-output layer
module delta3_module (
    clk, rst, step, controller, a, t, dadz, delta3
);
    input clk, rst;
    input [3:0] step, controller;
    input signed [15:0] a;
    input signed [15:0] t;
    input signed [15:0] dadz;
    output signed [15:0] delta3;

    reg signed [31:0] temp;

    always @(posedge clk ) begin
        if(rst) begin
            temp = 31'd0;
        end
        else begin
            if(step != 4'd0) begin
                if(controller == 4'd7) begin
                    temp <= (a - t)*dadz;
                end
                else temp = temp;
            end
            else temp = temp;
        end
    end

    assign delta3 = temp[25:10];
endmodule

////////////////////////////////////////////////////



////////////////////////////////////////////////////

//dw is a module that generates new parameter for updating node weight
module dw_module (
    clk, rst, delta, a, dw
);
    input clk, rst;
    input signed [15:0] delta, a;
    output signed [15:0] dw;

    reg signed [31:0] temp;

    always @(posedge clk ) begin
        if(rst) begin
            temp = 31'd0;
        end
        else temp = delta * a;
    end
    assign dw = temp[25:10];
endmodule

////////////////////////////////////////////////////

//dw2ram is a module that read memory to get dw2_0 to dw2_14
//need to be checked again
module dw2ram (
    clk, rst, controller, data_in, 
    dw2_0, dw2_1, dw2_2, dw2_3, dw2_4, 
    dw2_5, dw2_6, dw2_7, dw2_8,
);
    input clk, rst;
    input [3:0] controller;
    input [15:0] data_in;
    output [15:0] dw2_0, dw2_1, dw2_2, dw2_3, dw2_4, 
    dw2_5, dw2_6, dw2_7, dw2_8;
    reg [15:0] mem [0:14];
    always @(posedge clk ) begin
        if(rst) begin
            mem[0] =0; 
            mem[1] =0; 
            mem[2] =0; 
            mem[3] =0; 
            mem[4] =0; 
            mem[5] =0; 
            mem[6] =0; 
            mem[7] =0; 
            mem[8] =0; 
        end
        else mem[controller - (4'd10)] = data_in;
    end

    assign dw2_0 = mem[0]; 
    assign dw2_1 = mem[1]; 
    assign dw2_2 = mem[2]; 
    assign dw2_3 = mem[3];
    assign dw2_4 = mem[4];
    assign dw2_5 = mem[5]; 
    assign dw2_6 = mem[6]; 
    assign dw2_7 = mem[7];
    assign dw2_8 = mem[8]; 
endmodule

////////////////////////////////////////////////////

//dw3ram is a module that read memory to get dw3_0 to dw3_4
//need to be checked again
module dw3ram (
    clk, rst, controller, data_in,
    dw3_0, dw3_1, dw3_2, dw3_3, dw3_4
);
    input clk, rst;
    input [4:0] controller;
    input [15:0] data_in;
    output [15:0] dw3_0, dw3_1, dw3_2, dw3_3, dw3_4;

    reg [15:0] mem [0:4];
    always @(posedge clk ) begin
        if(rst) begin
            mem[0] =0; 
            mem[1] =0; 
            mem[2] =0; 
            mem[3] =0; 
            mem[4] =0;
        end
        else mem[controller - (4'd10)] = data_in;
    end

    assign dw3_0 = mem[0]; 
    assign dw3_1 = mem[1];
    assign dw3_2 = mem[2]; 
    assign dw3_3 = mem[3]; 
    assign dw3_4 = mem[4];
endmodule

////////////////////////////////////////////////////

//
module dw_adder_module (
    clk, rst, step, controller, dw, deltaw
);
    input clk, rst;
    input [3:0] step, controller;
    input signed [15:0] dw;
    output signed [15:0] deltaw;

    parameter [15:0] unit_error = -16'b000000_0001100110; //0.1
    reg signed [31:0] delw;

    always @(posedge clk ) begin
        if(rst) begin
            delw <= 32'd0;
        end
        else begin
            if(step == 4'd1) begin
                delw <= 32'd0;
            end
            else begin
                if(controller == 4'd9) begin
                    delw <= delw + (unit_error*dw);
                end
                else delw <= delw;
            end
        end
    end
    
    assign deltaw = delw[25:10];
    
endmodule

