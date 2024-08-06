// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

void Vtop___024root___ico_sequent__TOP__0(Vtop___024root* vlSelf);

void Vtop___024root___eval_ico(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_ico\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered.word(0U))) {
        Vtop___024root___ico_sequent__TOP__0(vlSelf);
    }
}

extern const VlUnpacked<CData/*0:0*/, 32> Vtop__ConstPool__TABLE_h16ae72db_0;
extern const VlUnpacked<CData/*0:0*/, 32> Vtop__ConstPool__TABLE_h5ca3c4cf_0;
extern const VlUnpacked<CData/*0:0*/, 32> Vtop__ConstPool__TABLE_he2e40b8f_0;
extern const VlUnpacked<CData/*1:0*/, 32> Vtop__ConstPool__TABLE_h036e4d06_0;
extern const VlUnpacked<CData/*0:0*/, 32> Vtop__ConstPool__TABLE_heff3cf5f_0;
extern const VlUnpacked<CData/*0:0*/, 32> Vtop__ConstPool__TABLE_hcc149f2f_0;

VL_INLINE_OPT void Vtop___024root___ico_sequent__TOP__0(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ico_sequent__TOP__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1;
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1 = 0;
    SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1;
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1 = 0;
    CData/*4:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    // Body
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__start 
        = vlSelfRef.tb_seq_multiplier__DOT__start;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__multiplier 
        = vlSelfRef.tb_seq_multiplier__DOT__Multiplier;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__multiplicand 
        = vlSelfRef.tb_seq_multiplier__DOT__Multiplicand;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__rst;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done 
        = (0x10U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in 
        = (1U & (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__start 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__start;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__start 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__start;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__multiplier;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__multiplicand;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__rst_n;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__rst_n;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__multiplicand_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__accumulator_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__count_done 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count_done 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__in 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clk 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__rst_n 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0;
    __Vtableidx1 = (((IData)(vlSelfRef.tb_seq_multiplier__DOT__start) 
                     << 4U) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1) 
                                << 3U) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0) 
                                           << 2U) | 
                                          (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done) 
                                            << 1U) 
                                           | (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state)))));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state 
        = Vtop__ConstPool__TABLE_h16ae72db_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out 
        = Vtop__ConstPool__TABLE_he2e40b8f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op 
        = Vtop__ConstPool__TABLE_h036e4d06_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear 
        = Vtop__ConstPool__TABLE_hcc149f2f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready 
        = Vtop__ConstPool__TABLE_hcc149f2f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_count 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__ready 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready;
    vlSelfRef.tb_seq_multiplier__DOT__ready = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_ac 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_mltd 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_multr 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selA 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_count 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out 
        = (0xffffU & ((0U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                       ? (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out)
                       : ((2U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                           ? ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out) 
                              + (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out))
                           : ((1U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                               ? ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out) 
                                  - (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out))
                               : (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out)))));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__sel 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__sel 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__combined 
        = (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
            << 0x10U) | (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined 
        = ((0x80000000U & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                           << 0x10U)) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                                          << 0xfU) 
                                         | (0x7fffU 
                                            & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out) 
                                               >> 1U))));
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1 
        = ((0x8000U & (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out)) 
           | (0x7fffU & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                         >> 1U)));
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1 
        = ((0x8000U & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                       << 0xfU)) | (0x7fffU & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out) 
                                               >> 1U)));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__rst)
            ? (((~ (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out)) 
                & (0x8000U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__Multiplicand)))
                ? ((IData)(1U) + (~ vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined))
                : ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out)
                    ? 0U : vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined))
            : 0U);
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in1 
        = tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA)
            ? (IData)(tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1)
            : 0U);
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in1 
        = tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ)
            ? (IData)(tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1)
            : (IData)(vlSelfRef.tb_seq_multiplier__DOT__Multiplier));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__product 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product;
    vlSelfRef.tb_seq_multiplier__DOT__Product = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__in 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__in 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
}

void Vtop___024root___eval_triggers__ico(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__ico(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__ico\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    Vtop___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelfRef.__VicoTriggered.any();
    if (__VicoExecute) {
        Vtop___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vtop___024root___eval_act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}

void Vtop___024root___nba_sequent__TOP__0(Vtop___024root* vlSelf);

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__0(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1;
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1 = 0;
    SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1;
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1 = 0;
    CData/*4:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    CData/*4:0*/ __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count;
    __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count = 0;
    // Body
    __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__rst) 
           && (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state));
    if (vlSelfRef.tb_seq_multiplier__DOT__rst) {
        if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear) {
            __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count = 0U;
        } else if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_count) {
            __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count 
                = (0x1fU & ((IData)(1U) + (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count)));
        }
    } else {
        __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count = 0U;
    }
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count 
        = __Vdly__tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done 
        = (0x10U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count));
    if (vlSelfRef.tb_seq_multiplier__DOT__rst) {
        if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear) {
            vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out = 0U;
            vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out = 0U;
            vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out = 0U;
            vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next = 0U;
        } else {
            if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_mltd) {
                vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out 
                    = vlSelfRef.tb_seq_multiplier__DOT__Multiplicand;
            }
            if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_ac) {
                vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out 
                    = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
            }
            if (vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_multr) {
                vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out 
                    = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
                vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next 
                    = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
            }
        }
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out;
    } else {
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out = 0U;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out = 0U;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out = 0U;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out 
            = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out;
        vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next = 0U;
    }
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in 
        = (1U & (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__count_done 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count_done 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__multiplicand_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__accumulator_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q0 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0;
    __Vtableidx1 = (((IData)(vlSelfRef.tb_seq_multiplier__DOT__start) 
                     << 4U) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q_1) 
                                << 3U) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__Q0) 
                                           << 2U) | 
                                          (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__count_done) 
                                            << 1U) 
                                           | (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state)))));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state 
        = Vtop__ConstPool__TABLE_h16ae72db_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count 
        = Vtop__ConstPool__TABLE_h5ca3c4cf_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out 
        = Vtop__ConstPool__TABLE_he2e40b8f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op 
        = Vtop__ConstPool__TABLE_h036e4d06_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1 
        = Vtop__ConstPool__TABLE_heff3cf5f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear 
        = Vtop__ConstPool__TABLE_hcc149f2f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready 
        = Vtop__ConstPool__TABLE_hcc149f2f_0[__Vtableidx1];
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_count 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__ready 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready;
    vlSelfRef.tb_seq_multiplier__DOT__ready = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_ac 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_mltd 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_multr 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selA 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_count 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_count;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ_1 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ_1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out 
        = (0xffffU & ((0U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                       ? (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out)
                       : ((2U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                           ? ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out) 
                              + (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out))
                           : ((1U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__alu_op))
                               ? ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out) 
                                  - (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out))
                               : (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out)))));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__enable 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clear 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__sel 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__sel 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__alu_op 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU_out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__combined 
        = (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
            << 0x10U) | (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined 
        = ((0x80000000U & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                           << 0x10U)) | (((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                                          << 0xfU) 
                                         | (0x7fffU 
                                            & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out) 
                                               >> 1U))));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__rst)
            ? (((~ (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out)) 
                & (0x8000U == (IData)(vlSelfRef.tb_seq_multiplier__DOT__Multiplicand)))
                ? ((IData)(1U) + (~ vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined))
                : ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__en_out)
                    ? 0U : vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined))
            : 0U);
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1 
        = ((0x8000U & (IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out)) 
           | (0x7fffU & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                         >> 1U)));
    tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1 
        = ((0x8000U & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out) 
                       << 0xfU)) | (0x7fffU & ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out) 
                                               >> 1U)));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in1 
        = tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA)
            ? (IData)(tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_accumulator__in1)
            : 0U);
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in1 
        = tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0 
        = ((IData)(vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ)
            ? (IData)(tb_seq_multiplier__DOT__uut__DOT__D1__DOT____Vcellinp__mux_multiplier__in1)
            : (IData)(vlSelfRef.tb_seq_multiplier__DOT__Multiplier));
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__product 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product;
    vlSelfRef.tb_seq_multiplier__DOT__Product = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__in 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__in 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
    vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__out 
        = vlSelfRef.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtop___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vtop___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtop___024root___eval_phase__nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtop___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__ico(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelfRef.__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("/home/ibraheem/Xcelerium-IC-Design-Training/Ibrahim/src/Seq_Multiplier_Cocotb/test/tb_seq_multiplier.sv", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vtop___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelfRef.__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("/home/ibraheem/Xcelerium-IC-Design-Training/Ibrahim/src/Seq_Multiplier_Cocotb/test/tb_seq_multiplier.sv", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelfRef.__VactIterCount))) {
#ifdef VL_DEBUG
                Vtop___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("/home/ibraheem/Xcelerium-IC-Design-Training/Ibrahim/src/Seq_Multiplier_Cocotb/test/tb_seq_multiplier.sv", 1, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vtop___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vtop___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
