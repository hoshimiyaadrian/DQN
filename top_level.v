module top_level (
    
);

fwd_prop forward_porp(
    clk, rst,
    //input deltaw2
    deltaw2_11, deltaw2_12, deltaw2_13, deltaw2_14, deltaw2_15,
    deltaw2_21, deltaw2_22, deltaw2_23, deltaw2_24, deltaw2_25,
    deltaw2_31, deltaw2_32, deltaw2_33, deltaw2_34, deltaw2_35,
    deltaw2_41, deltaw2_42, deltaw2_43, deltaw2_44, deltaw2_45,
    deltaw2_51, deltaw2_52, deltaw2_53, deltaw2_54, deltaw2_55,
    deltaw2_61, deltaw2_62, deltaw2_63, deltaw2_64, deltaw2_65,
    deltaw2_71, deltaw2_72, deltaw2_73, deltaw2_74, deltaw2_75,
    deltaw2_81, deltaw2_82, deltaw2_83, deltaw2_84, deltaw2_85,
    deltaw2_91, deltaw2_92, deltaw2_93, deltaw2_94, deltaw2_95,
    //input deltab2
    deltab2_1, deltab2_2, deltab2_3, deltab2_4, deltab2_5,
    //input deltaw3
    deltaw3_11, deltaw3_12, deltaw3_13, deltaw3_14,
    deltaw3_21, deltaw3_22, deltaw3_23, deltaw3_24,
    deltaw3_31, deltaw3_32, deltaw3_33, deltaw3_34,
    deltaw3_41, deltaw3_42, deltaw3_43, deltaw3_44,
    deltaw3_51, deltaw3_52, deltaw3_53, deltaw3_54,
    //input deltab3
    deltab3_1, deltab3_2, deltab3_3, deltab3_4,

    //control
    ctrl, step, st,

    //output a2st1
    a2_1out, a2_2out, a2_3out, a2_4out, a2_5out,

    //output w3
    w3_11out, w3_12out, w3_13out, w3_14out,
    w3_21out, w3_22out, w3_23out, w3_24out,
    w3_31out, w3_32out, w3_33out, w3_34out,
    w3_41out, w3_42out, w3_43out, w3_44out,
    w3_51out, w3_52out, w3_53out, w3_54out,

    //output a3st1
    a3_1out, a3_2out, a3_3out, a3_4out,

    //output a2st
    a2st_1, a2st_2, a2st_3, a2st_4, a2st_5,

    //output a3st
    a3st_1, a3st_2, a3st_3, a3st_4
);

Action_determiner actiondeterminer(
    clk, rst, step, controller, episode
    Q0, Q1, Q2, Q3, act, st, st1
);

Backward backward_prop(
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
    
endmodule