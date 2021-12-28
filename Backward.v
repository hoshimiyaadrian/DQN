module Backward (
//input    
    clk, rst, 
    
    //control
    step, controller, st, st1,

    //action
    act,

    //a3
    a3_0, a3_1, a3_2, a3_3,

    //a2
    a2_0, a2_1, a2_2, a2_3, a2_4,
    
    //weight hidden-output layer
    w3_0_0, w3_0_1, w3_0_2, w3_0_3, w3_0_4, 
    w3_1_0, w3_1_1, w3_1_2, w3_1_3, w3_1_4, 
    w3_2_0, w3_2_1, w3_2_2, w3_2_3, w3_2_4,
    w3_3_0, w3_3_1, w3_3_2, w3_3_3, w3_3_4,

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
    input [1:0] act;
    input [3:0] step, controller, st, st1;
    input signed [15:0] a3_0, a3_1, a3_2, a3_3;
    input signed [15:0] a2_0, a2_1, a2_2, a2_3, a2_4;
    input signed [15:0] w3_0_0, w3_1_0, w3_2_0, w3_3_0,
                        w3_0_1, w3_1_1, w3_2_1, w3_3_1,
                        w3_0_2, w3_1_2, w3_2_2, w3_3_2,
                        w3_0_3, w3_1_3, w3_2_3, w3_3_3,
                        w3_0_4, w3_1_4, w3_2_4, w3_3_4;
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

    ////////////////////////////////////////////////
    wire signed [15:0] reward;
    wire signed [15:0] dadz2_0, dadz2_1, dadz2_2, dadz2_3, dadz2_4;
    wire signed [15:0] a_2_0, a_2_1, a_2_2, a_2_3, a_2_4;
    wire signed [15:0] delta3_0, delta3_1, delta3_2, delta3_4;
    

    //a_reg_module(1) ==> dadz_module(6) =========================v
    //                ==> reward_module(6) ==> delta3_module(7) ==> delta2 (8)
    //                ==> Qt ================^                  ==> dcdw23 (9)
    //a_3st1          ==> maxQt1(6) =========^
    
    //delta2 (8) ==> dcdw12 (9) ==> dw db (10)

    //a_reg_module
    //////////////////////////////////////
    ////////NOT YET
    /////////////////////////////////////

    //reward_module ==> 1 module
    reward_module rewardmodule(clk, st, st1, step, reward);

    //dadz_module ==> 5 module
    //there is only dadz2 since outfunc is linear
    //matlab example for dadz2: 
    //0.22990627
    //0.237164279
    //0.208961422
    //0.200132191
    //0.24395663
    dadz_module dadz2_0_module(
        clk, rst, step, controller, a_2_0, dadz2_0
    );
    dadz_module dadz2_1_module(
        clk, rst, step, controller, a_2_1, dadz2_1
    );
    dadz_module dadz2_2_module(
        clk, rst, step, controller, a_2_2, dadz2_2
    );
    dadz_module dadz2_3_module(
        clk, rst, step, controller, a_2_3, dadz2_3
    );
    dadz_module dadz2_4_module(
        clk, rst, step, controller, a_2_4, dadz2_4
    );

    //delta3_module ==> 4 module
    //matlab example for delta3: 
    //0
    //0
    //-4.974330622
    //0
    delta3_module delta3_0_mod(
        clk, rst, act, step, controller, reward, maxQt1, Qt, delta3_0
    );
    delta3_module1 delta3_1_mod(
        clk, rst, act, step, controller, reward, maxQt1, Qt, delta3_1
    );
    delta3_module2 delta3_2_mod(
        clk, rst, act, step, controller, reward, maxQt1, Qt, delta3_2
    );
    delta3_module3 delta3_3_mod(
        clk, rst, act, step, controller, reward, maxQt1, Qt, delta3_3
    );

    //dcdw23_module
    //matlab example for dcdw23:
    // 0	0	-1.782042232	0
    // 0	0	-1.923599308	0
    // 0	0	-1.479466381	0
    // 0	0	-1.376342499	0
    // 0	0	-2.100465254	0
    //////////////////////////////////////
    ////////NOT YET
    /////////////////////////////////////

    //delta2_module ==> 5 module
    //matlab example for delta2:
    //-0.061026997
    //-0.677305792
    //-0.15251602
    //-0.586667621
    //-0.84917142
    delta2_module delta2_0_mod(
        clk, rst, controller, step, 
        w3_0_0, w3_1_0, w3_2_0, w3_3_0,
        delta3_0, delta3_1, delta3_2, delta3_3, 
        dadz2_0, delta2_0
    );
    delta2_module delta2_1_mod(
        clk, rst, controller, step, 
        w3_0_1, w3_1_1, w3_2_1, w3_3_1,
        delta3_0, delta3_1, delta3_2, delta3_3, 
        dadz2_1, delta2_1
    );
    delta2_module delta2_2_mod(
        clk, rst, controller, step, 
        w3_0_2, w3_1_2, w3_2_2, w3_3_2,
        delta3_0, delta3_1, delta3_2, delta3_3, 
        dadz2_2, delta2_2
    );
    delta2_module delta2_3_mod(
        clk, rst, controller, step, 
        w3_0_3, w3_1_3, w3_2_3, w3_3_3,
        delta3_0, delta3_1, delta3_2, delta3_3, 
        dadz2_3, delta2_3
    );
    delta2_module delta2_4_mod(
        clk, rst, controller, step, 
        w3_0_4, w3_1_4, w3_2_4, w3_3_4,
        delta3_0, delta3_1, delta3_2, delta3_4, 
        dadz2_4, delta2_4
    );

    //dcdw12_module
    //matlab example for dcdw12:
    // -0.061026997	-0.677305792	-0.15251602	-0.586667621	-0.84917142
    // 0	         0	             0	         0	             0
    // 0	         0           	 0	         0	             0
    // 0	         0	             0	         0	             0
    // 0	         0	             0	         0	             0
    // 0	         0	             0	         0	             0
    // 0	         0	             0	         0	             0
    // 0	         0	             0         	 0	             0
    // 0	         0	             0	         0	             0
    //////////////////////////////////////
    ////////NOT YET
    /////////////////////////////////////
endmodule