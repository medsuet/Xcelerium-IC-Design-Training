// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VTOP__SYMS_H_
#define VERILATED_VTOP__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vtop.h"

// INCLUDE MODULE CLASSES
#include "Vtop___024root.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vtop__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vtop* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vtop___024root                 TOP;

    // SCOPE NAMES
    VerilatedScope __Vscope_tb_seq_multiplier;
    VerilatedScope __Vscope_tb_seq_multiplier__uut;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__C1;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__ALU;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator;
    VerilatedScope __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier;

    // SCOPE HIERARCHY
    VerilatedHierarchy __Vhier;

    // CONSTRUCTORS
    Vtop__Syms(VerilatedContext* contextp, const char* namep, Vtop* modelp);
    ~Vtop__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
