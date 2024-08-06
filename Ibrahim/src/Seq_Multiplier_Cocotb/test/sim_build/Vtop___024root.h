// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated.h"


class Vtop__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtop___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ tb_seq_multiplier__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__rst;
        CData/*0:0*/ tb_seq_multiplier__DOT__start;
        CData/*0:0*/ tb_seq_multiplier__DOT__ready;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__start;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__ready;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__count_done;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__Q0;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__Q_1;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__en_multr;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__en_mltd;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__en_count;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__en_ac;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__selQ;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__selQ_1;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__selA;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__en_out;
        CData/*1:0*/ tb_seq_multiplier__DOT__uut__DOT__alu_op;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__start;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__count_done;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q0;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q_1;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac;
        CData/*1:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__start;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_count;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac;
        CData/*1:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ_1;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_out;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count_done;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q0;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_1;
        CData/*4:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out3;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__enable;
    };
    struct {
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__sel;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__enable;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__sel;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clk;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__rst_n;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clear;
        CData/*0:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__enable;
        CData/*1:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__alu_op;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __VicoFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__tb_seq_multiplier__DOT__rst__0;
        CData/*0:0*/ __VactContinue;
        SData/*15:0*/ tb_seq_multiplier__DOT__Multiplicand;
        SData/*15:0*/ tb_seq_multiplier__DOT__Multiplier;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__multiplier;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__multiplicand;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__in;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in0;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in1;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__in;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in0;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in1;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__in;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__multiplicand_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__accumulator_out;
        SData/*15:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out;
        IData/*31:0*/ tb_seq_multiplier__DOT__exp;
        IData/*31:0*/ tb_seq_multiplier__DOT__Product;
        IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__product;
        IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product;
        IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined;
        IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__combined;
        IData/*31:0*/ __VactIterCount;
    };
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtop__Syms* const vlSymsp;

    // PARAMETERS
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_M = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_P = 0x00000020U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__WIDTH = 0x00000010U;
    static constexpr IData/*31:0*/ tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__WIDTH = 0x00000010U;

    // CONSTRUCTORS
    Vtop___024root(Vtop__Syms* symsp, const char* v__name);
    ~Vtop___024root();
    VL_UNCOPYABLE(Vtop___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
