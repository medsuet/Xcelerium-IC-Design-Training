// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

VL_ATTR_COLD void Vtop___024root___eval_static(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_static\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void Vtop___024root___eval_initial__TOP(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_initial(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtop___024root___eval_initial__TOP(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__clk__0 
        = vlSelfRef.tb_seq_multiplier__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__rst__0 
        = vlSelfRef.tb_seq_multiplier__DOT__rst;
}

VL_ATTR_COLD void Vtop___024root___eval_final(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_final\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_settle(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_settle\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("/home/ibraheem/Xcelerium-IC-Design-Training/Ibrahim/src/Seq_Multiplier_Cocotb/test/tb_seq_multiplier.sv", 1, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtop___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelfRef.__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void Vtop___024root___ico_sequent__TOP__0(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        Vtop___024root___ico_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vtop___024root___eval_triggers__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtop___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelfRef.__VstlTriggered.any();
    if (__VstlExecute) {
        Vtop___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__ico(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__ico\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VicoTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VicoTriggered.word(0U))) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge tb_seq_multiplier.clk or negedge tb_seq_multiplier.rst)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge tb_seq_multiplier.clk or negedge tb_seq_multiplier.rst)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ctor_var_reset\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelf->tb_seq_multiplier__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__rst = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__start = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__Multiplicand = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__Multiplier = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__exp = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__ready = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__Product = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__start = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__multiplier = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__multiplicand = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__product = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__ready = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__count_done = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__Q0 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__Q_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__en_multr = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__en_mltd = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__en_count = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__en_ac = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__selQ = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__selQ_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__selA = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__en_out = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__alu_op = VL_RAND_RESET_I(2);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__start = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__count_done = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q0 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op = VL_RAND_RESET_I(2);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__start = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_count = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op = VL_RAND_RESET_I(2);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_out = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count_done = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q0 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_1 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count = VL_RAND_RESET_I(5);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__combined = VL_RAND_RESET_I(32);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out3 = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__enable = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__in = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in0 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in1 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__sel = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__enable = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__in = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in0 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in1 = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__sel = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clear = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__enable = VL_RAND_RESET_I(1);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__in = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__alu_op = VL_RAND_RESET_I(2);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__multiplicand_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__accumulator_out = VL_RAND_RESET_I(16);
    vlSelf->tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out = VL_RAND_RESET_I(16);
    vlSelf->__Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__rst__0 = VL_RAND_RESET_I(1);
}
