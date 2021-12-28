//dw2ram is a module that read memory to get dw2_0 to dw2_8
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