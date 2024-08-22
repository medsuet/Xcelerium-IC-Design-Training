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
    num_bits=32
    num_tests=100
    c=0 #for counting the number of wrong answers
    d=0 #for counting the number of divisions by zero
    for i in range(num_tests):
        driver(dut,1,1,32,random.randrange(0,2**(num_bits-1)-1),random.randrange(0,2**(num_bits-1)-1));
        while(1):
            await RisingEdge(dut.clk)
            if ((dut.ready_dst.value==1)&(dut.valid_dst.value==1)):
                await RisingEdge(dut.clk)
                c,d=monitor(dut,c,d,num_bits)
                break
    print("There was/were ",c," wrong answer/s out of     ",num_tests,"test/s")
    print("There was/were ",d," division/s by zero out of ",num_tests,"test/s")

def driver(dut,driver_valid_src,driver_ready_dst,driver_N,driver_Q_initial,driver_M):
    dut.valid_src.value=driver_valid_src
    dut.ready_dst.value=driver_ready_dst
    dut.N.value=driver_N
    dut.Q_initial.value=driver_Q_initial
    dut.M.value=driver_M
def monitor(dut,c,d,num_bits):
    c_new=c
    d_new=d
    if ((int(dut.Quotient.value)==2**(num_bits-1)-1)and(int(dut.Remainder.value)==int(dut.Q_initial.value))):
        print("DIVISION BY ZERO")
        d_new=d_new+1
    elif(((int(dut.Quotient.value))!=int(dut.Q_initial.value)//(dut.M.value))or(int(dut.Remainder.value)!=int(dut.Q_initial.value)%int(dut.M.value))):
        print("Test: ",int(dut.Q_initial.value),"/",int(dut.M.value))
        print("My answers:      ","Quotient=",int(dut.Quotient.value)," and ","Remainder=",int(dut.Remainder.value))
        print("Actual answers:  ","Quotient=",dut.Q_initial.value//dut.M.value," and ","Remainder=",dut.Q_initial.value%dut.M.value)
        c_new=c_new+1
    return c_new,d_new