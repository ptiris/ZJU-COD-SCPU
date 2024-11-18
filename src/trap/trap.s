    j   start
dummy:
    nop
    nop
    nop
    nop
    nop
    j   dummy

start:
    li x31, 1
    li x5, 1
    add x6, x5, x1
    add x7, x6, x6
    li x3, 4
    li x4, 0x44
    csrrw x0, 773, x4
    csrrw x0, 768,
    ecall
    j dummy

trap:
    addi x2, x2, 128           # 为32个寄存器分配栈空间（每个寄存器4字节，总共128字节）
    sw x1,  124(x2)             # 保存 x1 (返回地址寄存器)
    sw x2,  120(x2)             # 保存 x2 (栈指针)
    sw x3,  116(x2)             # 保存 x3 (全局指针)
    sw x4,  112(x2)             # 保存 x4 (线程指针)
    sw x5,  108(x2)             # 保存 x5 (临时寄存器)
    sw x6,  104(x2)             # 保存 x6 (临时寄存器)
    sw x7,  100(x2)             # 保存 x7 (临时寄存器)
    sw x8,  96(x2)              # 保存 x8 (保存寄存器)
    sw x9,  92(x2)              # 保存 x9 (保存寄存器)
    sw x10, 88(x2)              # 保存 x10 (参数寄存器/返回值寄存器)
    sw x11, 84(x2)              # 保存 x11 (参数寄存器)
    sw x12, 80(x2)              # 保存 x12 (参数寄存器)
    sw x13, 76(x2)              # 保存 x13 (参数寄存器)
    sw x14, 72(x2)              # 保存 x14 (参数寄存器)
    sw x15, 68(x2)              # 保存 x15 (参数寄存器)
    sw x16, 64(x2)              # 保存 x16 (临时寄存器)
    sw x17, 60(x2)              # 保存 x17 (临时寄存器)
    sw x18, 56(x2)              # 保存 x18 (保存寄存器)
    sw x19, 52(x2)              # 保存 x19 (保存寄存器)
    sw x20, 48(x2)              # 保存 x20 (保存寄存器)
    sw x21, 44(x2)              # 保存 x21 (保存寄存器)
    sw x22, 40(x2)              # 保存 x22 (保存寄存器)
    sw x23, 36(x2)              # 保存 x23 (保存寄存器)
    sw x24, 32(x2)              # 保存 x24 (保存寄存器)
    sw x25, 28(x2)              # 保存 x25 (保存寄存器)
    sw x26, 24(x2)              # 保存 x26 (保存寄存器)
    sw x27, 20(x2)              # 保存 x27 (保存寄存器)
    sw x28, 16(x2)              # 保存 x28 (临时寄存器)
    sw x29, 12(x2)              # 保存 x29 (临时寄存器)
    sw x30, 8(x2)               # 保存 x30 (临时寄存器)
    sw x31, 4(x2)               # 保存 x31 (临时寄存器)
                                # mepc    =  res[12'h341];
                                # mscause =  res[12'h342];
                                # mtval   =  res[12'h343];
                                # mtvec   =  res[12'h305];
                                # mstatus =  res[12'h300];
                                
    csrrwi x5,834,0             # x5 = mscause
    csrrwi x6,835,0             # x6 = mtval
    csrrwi x7,833,0             # x7 = mepc
    csrrwi x10,768,0            # x10 = mstatus
    
    andi x8, x5, 4              # mscause & 100
    li x9,4
    beq x8,x9,io_int
    andi x8, x5, 2
    li x9,2
    beq x8,x9,ecall_int
    li x9,1
    beq x8,x9,ill_inst_exc
    j end_trap
    
    
io_int:
    addi x7,x7,0
    ori x10,x10,4             # x10 |= 100
    csrrw x0,768,x10          # mstatus = x10
    csrrw x0,833,x7           # mepc = x7 = mepc
    csrrw x0,835,x6           # mtval= x6 = mtval
    csrrci x0,834,x2          # mscause -= 010
    li x30,1
    j end_trap
ecall_int:
    addi x7,x7,4
    ori x10,x10,4             # x10 |= 100
    csrrw x0,768,x10          # mstatus = x10
    csrrw x0,833,x7           # mepc = x7 = mepc +4
    csrrw x0,835,x6           # mtval= x6 = mtval
    csrrci x0,834,x2          # mscause -= 010
    li x30,2
    j end_trap
    
ill_inst_exc:
    addi x7,x7,4
    ori x10,x10,4             # x10 |= 100
    csrrw x0,768,x10          # mstatus = x10
    csrrw x0,833,x7           # mepc = x7 = mepc +4
    csrrw x0,835,x6           # mtval= x6 = mtval
    csrrci x0,834,x2          # mscause -= 010
    li x30,3
    j end_trap
    
    
    
end_trap:
    # 恢复寄存器
    lw x31, 4(x2)               # 恢复 x31 (临时寄存器)
    lw x30, 8(x2)               # 恢复 x30 (临时寄存器)
    lw x29, 12(x2)              # 恢复 x29 (临时寄存器)
    lw x28, 16(x2)              # 恢复 x28 (临时寄存器)
    lw x27, 20(x2)              # 恢复 x27 (保存寄存器)
    lw x26, 24(x2)              # 恢复 x26 (保存寄存器)
    lw x25, 28(x2)              # 恢复 x25 (保存寄存器)
    lw x24, 32(x2)              # 恢复 x24 (保存寄存器)
    lw x23, 36(x2)              # 恢复 x23 (保存寄存器)
    lw x22, 40(x2)              # 恢复 x22 (保存寄存器)
    lw x21, 44(x2)              # 恢复 x21 (保存寄存器)
    lw x20, 48(x2)              # 恢复 x20 (保存寄存器)
    lw x19, 52(x2)              # 恢复 x19 (保存寄存器)
    lw x18, 56(x2)              # 恢复 x18 (保存寄存器)
    lw x17, 60(x2)              # 恢复 x17 (临时寄存器)
    lw x16, 64(x2)              # 恢复 x16 (临时寄存器)
    lw x15, 68(x2)              # 恢复 x15 (参数寄存器)
    lw x14, 72(x2)              # 恢复 x14 (参数寄存器)
    lw x13, 76(x2)              # 恢复 x13 (参数寄存器)
    lw x12, 80(x2)              # 恢复 x12 (参数寄存器)
    lw x11, 84(x2)              # 恢复 x11 (参数寄存器)
    lw x10, 88(x2)              # 恢复 x10 (参数寄存器/返回值寄存器)
    lw x9,  92(x2)              # 恢复 x9 (保存寄存器)
    lw x8,  96(x2)              # 恢复 x8 (保存寄存器)
    lw x7,  100(x2)             # 恢复 x7 (临时寄存器)
    lw x6,  104(x2)             # 恢复 x6 (临时寄存器)
    lw x5,  108(x2)             # 恢复 x5 (临时寄存器)
    lw x4,  112(x2)            
    lw x3,  116(x2)             
    lw x2,  120(x2)            
    lw x1,  124(x2)             
    addi x2, x2, -128           
    
    mret  # 30200073

    