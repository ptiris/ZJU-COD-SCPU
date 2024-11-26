j   start
dummy:
    nop
    nop
    nop
    nop
    nop
    j   dummy
start:                   #testbench on csrrw and csrrs
    li x31, 1
    li x1, 0xBEEF        #x1 = 0xBEEF
    auipc x30, 0 
    csrrw x2, 833, x1    #x2 = mepc, mepc = x1
    csrrw x2, 833, x0    #x2 = mepc, mepc = x0
    auipc x30, 0 
    bne x2, x1, dummy    #x2 == x1?
    li x3, 5             #x3 = 5
    csrrw x0, 305, x3    #mvec = x3
    li x4, 10            #x4 = 10
    csrrs x5, 305, x4    #x5 = mvec, mvec |= x4
    csrrw x6, 305, x0    #x6 = mvec, mvec = 0
    or x7, x4, x3        #x7 = x4|x3
    auipc x30, 0 
    bne x7,x6,dummy
    j   pass_1
pass_1:                   #test on csrrc
    li x31, 2
    li x2, 15
    csrrw x0, 835, x2     #mtval = 15
    li x3, 6              #x3 = 6
    li x4, 9
    csrrc x0, 835, x3    
    csrrw x5, 835, x0     #x5 = mtval, mtval = 0
    auipc x30, 0
    bne x5, x4, dummy
    j   pass_2
pass_2:
    li x31, 3
    li x3, 32
    li x4, 20
    csrrwi x0, 834, x20     #mcause = 20 (10100)
    csrrw x2, 834, x3       #x2 = mcause, mcause = 32 (100000)
    auipc x30, 0
    bne x2, x4, dummy     
    csrrsi x5, 834, x0      #x5 = mcause
    auipc x30, 0
    bne x3, x5, dummy       #
    csrrsi x3, 834, x10     #x3 = mcause, mcause = 0x2A
    csrrw x4, 834, x0       #x4 = mcause, mcause = 0
    li x7, 42
    auipc x30, 0
    bne x7, x4, dummy
    j   pass_3
pass_3:
    li x31, 4
    li x2, 13               #x2 = 45(01101) 
    li x4, 63
    li x9, 31
    csrrwi x0, 768, x31      #mstatus = 31(11111)
    csrrci x3, 768, x18      # 10010
    auipc x30, 0
    bne x3, x9, dummy
    csrrsi x5, 768, x0       #x5 = mstatus
    auipc x30, 0
    bne x2, x5, dummy
    j   pass_4

pass_4:
    li x31, 666
    j   dummy

