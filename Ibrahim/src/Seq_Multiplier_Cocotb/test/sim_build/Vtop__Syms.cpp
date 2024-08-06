// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtop__pch.h"
#include "Vtop.h"
#include "Vtop___024root.h"

// FUNCTIONS
Vtop__Syms::~Vtop__Syms()
{

    // Tear down scope hierarchy
    __Vhier.remove(0, &__Vscope_tb_seq_multiplier);
    __Vhier.remove(&__Vscope_tb_seq_multiplier, &__Vscope_tb_seq_multiplier__uut);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut, &__Vscope_tb_seq_multiplier__uut__C1);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut, &__Vscope_tb_seq_multiplier__uut__D1);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__ALU);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__mux_accumulator);
    __Vhier.remove(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__mux_multiplier);

}

Vtop__Syms::Vtop__Syms(VerilatedContext* contextp, const char* namep, Vtop* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
        // Check resources
        Verilated::stackCheck(77);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    // Setup scopes
    __Vscope_tb_seq_multiplier.configure(this, name(), "tb_seq_multiplier", "tb_seq_multiplier", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut.configure(this, name(), "tb_seq_multiplier.uut", "uut", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__C1.configure(this, name(), "tb_seq_multiplier.uut.C1", "C1", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1.configure(this, name(), "tb_seq_multiplier.uut.D1", "D1", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__ALU.configure(this, name(), "tb_seq_multiplier.uut.D1.ALU", "ALU", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.configure(this, name(), "tb_seq_multiplier.uut.D1.Accumulator_reg", "Accumulator_reg", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.configure(this, name(), "tb_seq_multiplier.uut.D1.Multiplicand_reg", "Multiplicand_reg", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.configure(this, name(), "tb_seq_multiplier.uut.D1.Multiplier_reg", "Multiplier_reg", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.configure(this, name(), "tb_seq_multiplier.uut.D1.mux_accumulator", "mux_accumulator", -12, VerilatedScope::SCOPE_MODULE);
    __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.configure(this, name(), "tb_seq_multiplier.uut.D1.mux_multiplier", "mux_multiplier", -12, VerilatedScope::SCOPE_MODULE);

    // Set up scope hierarchy
    __Vhier.add(0, &__Vscope_tb_seq_multiplier);
    __Vhier.add(&__Vscope_tb_seq_multiplier, &__Vscope_tb_seq_multiplier__uut);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut, &__Vscope_tb_seq_multiplier__uut__C1);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut, &__Vscope_tb_seq_multiplier__uut__D1);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__ALU);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__mux_accumulator);
    __Vhier.add(&__Vscope_tb_seq_multiplier__uut__D1, &__Vscope_tb_seq_multiplier__uut__D1__mux_multiplier);

    // Setup export functions
    for (int __Vfinal = 0; __Vfinal < 2; ++__Vfinal) {
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"Multiplicand", &(TOP.tb_seq_multiplier__DOT__Multiplicand), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"Multiplier", &(TOP.tb_seq_multiplier__DOT__Multiplier), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"Product", &(TOP.tb_seq_multiplier__DOT__Product), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"exp", &(TOP.tb_seq_multiplier__DOT__exp), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"ready", &(TOP.tb_seq_multiplier__DOT__ready), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"rst", &(TOP.tb_seq_multiplier__DOT__rst), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier.varInsert(__Vfinal,"start", &(TOP.tb_seq_multiplier__DOT__start), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"Q0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__Q0), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"Q_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__Q_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"alu_op", &(TOP.tb_seq_multiplier__DOT__uut__DOT__alu_op), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,1 ,1,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"count_done", &(TOP.tb_seq_multiplier__DOT__uut__DOT__count_done), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"en_ac", &(TOP.tb_seq_multiplier__DOT__uut__DOT__en_ac), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"en_count", &(TOP.tb_seq_multiplier__DOT__uut__DOT__en_count), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"en_mltd", &(TOP.tb_seq_multiplier__DOT__uut__DOT__en_mltd), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"en_multr", &(TOP.tb_seq_multiplier__DOT__uut__DOT__en_multr), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"en_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__en_out), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"multiplicand", &(TOP.tb_seq_multiplier__DOT__uut__DOT__multiplicand), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"multiplier", &(TOP.tb_seq_multiplier__DOT__uut__DOT__multiplier), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"product", &(TOP.tb_seq_multiplier__DOT__uut__DOT__product), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"ready", &(TOP.tb_seq_multiplier__DOT__uut__DOT__ready), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"selA", &(TOP.tb_seq_multiplier__DOT__uut__DOT__selA), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"selQ", &(TOP.tb_seq_multiplier__DOT__uut__DOT__selQ), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"selQ_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__selQ_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut.varInsert(__Vfinal,"start", &(TOP.tb_seq_multiplier__DOT__uut__DOT__start), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"Q0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q0), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"Q_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__Q_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"alu_op", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__alu_op), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,1 ,1,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"count_done", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__count_done), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"current_state", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__current_state), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"en_ac", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_ac), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"en_count", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_count), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"en_mltd", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_mltd), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"en_multr", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_multr), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"en_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__en_out), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"next_state", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__next_state), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"ready", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__ready), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"selA", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selA), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"selQ", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"selQ_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__selQ_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__C1.varInsert(__Vfinal,"start", &(TOP.tb_seq_multiplier__DOT__uut__DOT__C1__DOT__start), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"ALU_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"Q0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q0), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"Q1_in", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q1_in), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"Q_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"Q_next", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Q_next), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"WIDTH_M", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_M))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"WIDTH_P", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__WIDTH_P))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"accumulator_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__accumulator_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"alu_op", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__alu_op), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,1 ,1,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"combined", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__combined), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"count", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,1 ,4,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"count_done", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__count_done), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"en_ac", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_ac), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"en_count", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_count), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"en_mltd", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_mltd), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"en_multr", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_multr), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"en_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__en_out), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"multiplicand", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"multiplicand_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplicand_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"multiplier", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"multiplier_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__multiplier_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"mux_out0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out0), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"mux_out1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out1), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"mux_out3", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_out3), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"product", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__product), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"selA", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selA), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"selQ", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"selQ_1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__selQ_1), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"shifted_combined", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__shifted_combined), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1.varInsert(__Vfinal,"start", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__start), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__ALU.varInsert(__Vfinal,"ALU_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__ALU_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__ALU.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__ALU.varInsert(__Vfinal,"accumulator_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__accumulator_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__ALU.varInsert(__Vfinal,"alu_op", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__alu_op), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,1 ,1,0);
        __Vscope_tb_seq_multiplier__uut__D1__ALU.varInsert(__Vfinal,"multiplicand_out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__ALU__DOT__multiplicand_out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"enable", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__enable), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"in", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__in), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Accumulator_reg.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Accumulator_reg__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"enable", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__enable), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"in", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__in), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplicand_reg.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplicand_reg__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"clear", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clear), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"clk", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__clk), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"enable", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__enable), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"in", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__in), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__Multiplier_reg.varInsert(__Vfinal,"rst_n", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__Multiplier_reg__DOT__rst_n), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.varInsert(__Vfinal,"in0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in0), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.varInsert(__Vfinal,"in1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__in1), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.varInsert(__Vfinal,"out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_accumulator.varInsert(__Vfinal,"sel", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_accumulator__DOT__sel), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.varInsert(__Vfinal,"WIDTH", const_cast<void*>(static_cast<const void*>(&(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__WIDTH))), true, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1 ,31,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.varInsert(__Vfinal,"in0", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in0), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.varInsert(__Vfinal,"in1", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__in1), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.varInsert(__Vfinal,"out", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__out), false, VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,15,0);
        __Vscope_tb_seq_multiplier__uut__D1__mux_multiplier.varInsert(__Vfinal,"sel", &(TOP.tb_seq_multiplier__DOT__uut__DOT__D1__DOT__mux_multiplier__DOT__sel), false, VLVT_UINT8,VLVD_NODIR|VLVF_PUB_RW,0);
    }
}
