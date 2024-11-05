0x000 (00000097): auipc x1, 0
0x004 (0240006f): jal x0, 36
0x008 (00000013): addi x0, x0, 0
0x00c (00000013): addi x0, x0, 0
0x010 (00000013): addi x0, x0, 0
0x014 (00000013): addi x0, x0, 0
0x018 (00000013): addi x0, x0, 0
0x01c (00000013): addi x0, x0, 0
0x020 (00000013): addi x0, x0, 0
0x024 (fe5ff06f): jal x0, -28
0x028 (fe0090e3): bne x1, x0, -32
0x02c (00000863): beq x0, x0, 16
0x030 (00000f93): addi x31, x0, 0
0x034 (00000f17): auipc x30, 0
0x038 (fd1ff06f): jal x0, -48
0x03c (00100f93): addi x31, x0, 1
0x040 (fc0014e3): bne x0, x0, -56
0x044 (fc0062e3): bltu x0, x0, -60
0x048 (fff00093): addi x1, x0, -1
0x04c (0010c193): xori x3, x1, 1
0x050 (003181b3): add x3, x3, x3
0x054 (003181b3): add x3, x3, x3
0x058 (003181b3): add x3, x3, x3
0x05c (003181b3): add x3, x3, x3
0x060 (003181b3): add x3, x3, x3
0x064 (003181b3): add x3, x3, x3
0x068 (003181b3): add x3, x3, x3
0x06c (003181b3): add x3, x3, x3
0x070 (003181b3): add x3, x3, x3
0x074 (003181b3): add x3, x3, x3
0x078 (003181b3): add x3, x3, x3
0x07c (003181b3): add x3, x3, x3
0x080 (003181b3): add x3, x3, x3
0x084 (003181b3): add x3, x3, x3
0x088 (003181b3): add x3, x3, x3
0x08c (003181b3): add x3, x3, x3
0x090 (003181b3): add x3, x3, x3
0x094 (003181b3): add x3, x3, x3
0x098 (003181b3): add x3, x3, x3
0x09c (003181b3): add x3, x3, x3
0x0a0 (003181b3): add x3, x3, x3
0x0a4 (003181b3): add x3, x3, x3
0x0a8 (003181b3): add x3, x3, x3
0x0ac (003181b3): add x3, x3, x3
0x0b0 (003181b3): add x3, x3, x3
0x0b4 (003182b3): add x5, x3, x3
0x0b8 (005281b3): add x3, x5, x5
0x0bc (00318233): add x4, x3, x3
0x0c0 (00420333): add x6, x4, x4
0x0c4 (006303b3): add x7, x6, x6
0x0c8 (00106413): ori x8, x0, 1
0x0cc (01f06e13): ori x28, x0, 31
0x0d0 (01c3deb3): srl x29, x7, x28
0x0d4 (00000f17): auipc x30, 0
0x0d8 (f3d418e3): bne x8, x29, -208
0x0dc (00000f17): auipc x30, 0
0x0e0 (f27444e3): blt x8, x7, -216
0x0e4 (41c3deb3): sra x29, x7, x28
0x0e8 (003efeb3): and x29, x29, x3
0x0ec (00000f17): auipc x30, 0
0x0f0 (f1d19ce3): bne x3, x29, -232
0x0f4 (00040e93): addi x29, x8, 0
0x0f8 (007ee663): bltu x29, x7, 12
0x0fc (00000f17): auipc x30, 0
0x100 (f09ff06f): jal x0, -248
0x104 (00000013): addi x0, x0, 0
0x108 (00200f93): addi x31, x0, 2
0x10c (407301b3): sub x3, x6, x7
0x110 (40338233): sub x4, x7, x3
0x114 (00102493): slti x9, x0, 1
0x118 (0041a533): slt x10, x3, x4
0x11c (00322533): slt x10, x4, x3
0x120 (00000f17): auipc x30, 0
0x124 (eea482e3): beq x9, x10, -284
0x128 (01e1de93): srli x29, x3, 30
0x12c (009e8663): beq x29, x9, 12
0x130 (00000f17): auipc x30, 0
0x134 (ed5ff06f): jal x0, -300
0x138 (00000013): addi x0, x0, 0
0x13c (00300f93): addi x31, x0, 3
0x140 (0030a513): slti x10, x1, 3
0x144 (0012a5b3): slt x11, x5, x1
0x148 (0030a633): slt x12, x1, x3
0x14c (0ff57513): andi x10, x10, 255
0x150 (00b57533): and x10, x10, x11
0x154 (00c57533): and x10, x10, x12
0x158 (00000f17): auipc x30, 0
0x15c (ea0506e3): beq x10, x0, -340
0x160 (0080b533): sltu x10, x1, x8
0x164 (00000f17): auipc x30, 0
0x168 (ea0510e3): bne x10, x0, -352
0x16c (00343533): sltu x10, x8, x3
0x170 (00000f17): auipc x30, 0
0x174 (e8050ae3): beq x10, x0, -364
0x178 (0030b513): sltiu x10, x1, 3
0x17c (00000f17): auipc x30, 0
0x180 (e80514e3): bne x10, x0, -376
0x184 (00100593): addi x11, x0, 1
0x188 (00b51663): bne x10, x11, 12
0x18c (00000f17): auipc x30, 0
0x190 (e79ff06f): jal x0, -392
0x194 (00000013): addi x0, x0, 0
0x198 (00400f93): addi x31, x0, 4
0x19c (0033e5b3): or x11, x7, x3
0x1a0 (00658663): beq x11, x6, 12
0x1a4 (00000f17): auipc x30, 0
0x1a8 (e61ff06f): jal x0, -416
0x1ac (00000013): addi x0, x0, 0
0x1b0 (00500f93): addi x31, x0, 5
0x1b4 (02000913): addi x18, x0, 32
0x1b8 (00592023): sw x5, 0(x18)
0x1bc (00492223): sw x4, 4(x18)
0x1c0 (00092d83): lw x27, 0(x18)
0x1c4 (005dcdb3): xor x27, x27, x5
0x1c8 (00692023): sw x6, 0(x18)
0x1cc (00092e03): lw x28, 0(x18)
0x1d0 (01c34db3): xor x27, x6, x28
0x1d4 (00000f17): auipc x30, 0
0x1d8 (e20d98e3): bne x27, x0, -464
0x1dc (a0000a37): lui x20, -393216
0x1e0 (01492423): sw x20, 8(x18)
0x1e4 (fedcbdb7): lui x27, -4661
0x1e8 (40cddd93): srai x27, x27, 12
0x1ec (00800e13): addi x28, x0, 8
0x1f0 (01cd9db3): sll x27, x27, x28
0x1f4 (0ffded93): ori x27, x27, 255
0x1f8 (00b90e83): lb x29, 11(x18)
0x1fc (01ddfdb3): and x27, x27, x29
0x200 (01b92423): sw x27, 8(x18)
0x204 (00895d83): lhu x27, 8(x18)
0x208 (ffff0a37): lui x20, -16
0x20c (01ba7a33): and x20, x20, x27
0x210 (00000f17): auipc x30, 0
0x214 (de0a1ae3): bne x20, x0, -524
0x218 (00600f93): addi x31, x0, 6
0x21c (00a94e03): lbu x28, 10(x18)
0x220 (00b94e83): lbu x29, 11(x18)
0x224 (008e9e93): slli x29, x29, 8
0x228 (01ceeeb3): or x29, x29, x28
0x22c (010e9e93): slli x29, x29, 16
0x230 (01ddeeb3): or x29, x27, x29
0x234 (00892e03): lw x28, 8(x18)
0x238 (00000f17): auipc x30, 0
0x23c (ddde16e3): bne x28, x29, -564
0x240 (00092023): sw x0, 0(x18)
0x244 (01b91023): sh x27, 0(x18)
0x248 (0d000e13): addi x28, x0, 208
0x24c (01c90123): sb x28, 2(x18)
0x250 (00092e03): lw x28, 0(x18)
0x254 (00d0deb7): lui x29, 3341
0x258 (ba0e8e93): addi x29, x29, -1120
0x25c (00000f17): auipc x30, 0
0x260 (dbde14e3): bne x28, x29, -600
0x264 (00291d83): lh x27, 2(x18)
0x268 (0d000e13): addi x28, x0, 208
0x26c (00000f17): auipc x30, 0
0x270 (d9cd9ce3): bne x27, x28, -616
0x274 (00700f93): addi x31, x0, 7
0x278 (00000f17): auipc x30, 0
0x27c (d800d6e3): bge x1, x0, -628
0x280 (00145663): bge x8, x1, 12
0x284 (00000f17): auipc x30, 0
0x288 (d81ff06f): jal x0, -640
0x28c (00000f17): auipc x30, 0
0x290 (d6107ce3): bgeu x0, x1, -648
0x294 (00000f17): auipc x30, 0
0x298 (d61478e3): bgeu x8, x1, -656
0x29c (00000a17): auipc x20, 0
0x2a0 (2ac00ae7): jalr x21, 684(x0)
0x2a4 (00000f17): auipc x30, 0
0x2a8 (d61ff06f): jal x0, -672
0x2ac (008a0a13): addi x20, x20, 8
0x2b0 (00000f17): auipc x30, 0
0x2b4 (d55a1ae3): bne x20, x21, -684
0x2b8 (66600f93): addi x31, x0, 1638
0x2bc (d4dff06f): jal x0, -692
