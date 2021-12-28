//dw_adder is a module that generates sum of capital delta weight
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

////////////////////////////
//test bench for dw_adder
module dw_adder_module_tb ();
    reg clk, rst;
    reg [3:0] step, controller;
    reg signed [15:0] dw;
    wire signed [15:0] deltaw;

    dw_adder_module dw_adder_tb(
        clk, rst, step, controller, dw, deltaw
    );

    initial begin 
        clk = 1'b1;
        forever #50 clk = ~clk;
    end

    initial begin
        rst = 1;
        step = 4'd0;
        controller = 4'd4;
        
        #200
        rst = 0;
        step = 1;
        controller = 4'd5;
        
        #100
        step = 2;
        controller = 4'd6;
        #100
        controller = 4'd7;
        #100
        controller = 4'd8;
        #100
        controller = 4'd9;

        #100
        step = 3;
        controller = 4'd5;
        #100
        controller = 4'd6;
        #100
        controller = 4'd7;
        #100
        controller = 4'd8;
        #100
        controller = 4'd9;

        #100
        step = 4;
        controller = 4'd5;
    end

    initial begin
        dw = 16'b000000_1000000000;

        #800
        dw = 16'b000010_0000000000;
    end
endmodule 