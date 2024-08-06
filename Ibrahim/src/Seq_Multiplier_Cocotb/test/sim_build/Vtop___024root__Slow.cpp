// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop__Syms.h"
#include "Vtop___024root.h"

// Parameter definitions for Vtop___024root
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_M;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_P;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__WIDTH;
constexpr IData/*31:0*/ Vtop___024root::tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__WIDTH;


void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf);

Vtop___024root::Vtop___024root(Vtop__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtop___024root___ctor_var_reset(this);
}

void Vtop___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtop___024root::~Vtop___024root() {
}
