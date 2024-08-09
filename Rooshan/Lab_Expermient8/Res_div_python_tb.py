import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer,RisingEdge,FallingEdge
@cocotb.test()
async def test_Res_div(dut):
    """ 
    """ 
    clock =Clock(dut.clk,10,units="us")
    cocotb.start_soon(clock.start())
    dut.reset.value=1
    await Timer(10,"us")
    dut.reset.value=0
    await Timer(10,"us")
    dut.reset.value=1
    await Timer(10,"us")
    Res_Div #(5) DUT(.clk(clk),.reset(reset),.valid_src(valid_src),.ready_dst(ready_dst),.N(N),.Q_initial(VALUE1),.M(VALUE2),.Remainder(Remainder),.Quotient(Quotient),.ready_src(ready_src),.valid_dst(valid_dst));
    dut.valid_src.value=1
    dut.ready_dst.value=1
    dut.N=5
    dut.Q_initial.value=12
    dut.M.value=3
    for i in range (5):
        await(RisingEdge)
    print("Quotient=",dut.Quotient.value)
    print("Remainder=",dut.Remainder.value)
    