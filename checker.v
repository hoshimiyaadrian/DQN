module checker (
    clk, rst, act, step, controller, st, st1
);
    input clk, rst;
    input [1:0] act;
    input [3:0] step, controller;
    output [3:0] st, st1;

    reg [3:0] st_temp, st1_temp;

    always @(posedge clk ) begin
        if (rst) 
        begin
            st_temp <= 4'd1;
            st1_temp <= 4'd1;
        end 
        else 
        begin
            if(step != 4'd0) begin
                if(controller == 4'd1)
                 begin
                    st_temp <= st1_temp;
                 end
                else 
                begin
                    if(controller == 4'd6) 
                    begin
                        if (step == 4'd14) begin
                            st1_temp <= 4'd1;
                        end 
                        else 
                        begin
                            
                        end
                        case (act)
                            2'd0 : begin //right
                                if((st_temp == 4'd3) || (st_temp == 4'd6) || (st_temp == 4'd9)) begin
                                    st1_temp <= st_temp;
                                end
                                else  st1_temp <= st_temp + 4'd1;
                            end
                            2'd1 : begin //up
                                if((st_temp == 4'd1) || (st_temp == 4'd2) || (st_temp == 4'd3)) begin
                                    st1_temp <= st_temp;
                                end
                                else  st1_temp <= st_temp - 4'd3;
                            end
                            2'd2 : begin //left
                                if((st_temp == 4'd1) || (st_temp == 4'd4) || (st_temp == 4'd7)) begin
                                    st1_temp <= st_temp;
                                end
                                else  st1_temp <= st_temp - 4'd1;
                            end
                            2'd3 : begin //down
                                if((st_temp == 4'd7) || (st_temp == 4'd8) || (st_temp == 4'd9)) begin
                                    st1_temp <= st_temp;
                                end
                                else  st1_temp <= st_temp + 4'd3;
                            end
                        endcase
                    end
                    else begin
                        st1_temp <= st1_temp;
                        st_temp  <= st_temp;
                    end
                end
            end
            else begin
                st_temp <= st_temp;
                st1_temp <= st1_temp;
            end
        end
    end
endmodule

module checker_tb ();
    reg clk, rst;
    reg [1:0] act;
    reg [3:0] step, controller;
    wire [3:0] st, st1;

    checker check_mod(
        clk, rst, act, step, controller, st, st1
    );

    initial begin 
        clk = 1'b1;
        forever #50 clk = ~clk;
    end
    initial begin
        rst = 1;
        act = 2'd0;
    end

endmodule