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

////////////////////////////
//test bench for dw_module
module dw_module_tb ();
    reg clk, rst;
    reg signed [15:0] delta, a;
    wire signed [15:0] dw;

    dw_module dw_tb (
        clk, rst, delta, a, dw
    );

    initial begin 
        clk = 1'b1;
        forever #50 clk = ~clk;
    end

    initial begin
        rst = 1;
        delta = 16'b000000_1000000000;
        a = 16'b000010_0000000000;

        #200
        rst = 0;

        #100
        delta = 16'b000100_0000000000;
        a = 16'b000010_0000000000;
    end
endmodule