module test (clk, rst, a, b, c, d);
    input clk, rst;
    input [31:0] a;
    output reg [31:0] b,c,d;

    always @(posedge clk ) begin
        if(rst) begin
            b = 0;
            c = 0;
            d = 0;
        end
        else begin
            b <= a + 5;
            c = b + 3;
            d = c + 10;    
        end
    end
endmodule

module test_tb ();
    reg clk, rst;
    reg [31:0] a;
    wire [31:0] b,c,d;

    test tb (clk, rst, a, b, c, d);
    initial 
    begin 
        clk = 1'b1;
        forever #50 clk = ~clk;
    end

    initial begin
        rst = 1;
        a = 3;
        #200
        
        rst = 0;
        a = 5;

        #300
        a = 7;
    end
endmodule 