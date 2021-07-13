/*
 * Copyright (c) 2021. Xing Tang. All Rights Reserved.
 */
        .section .entry, "ax", %progbits
        .align 3
        .global _start
_start:
        /* Setup temporary stack */
        lla     s4, _stack
        li      s5, 0x1000
        add     sp, s4, s5
        call main
_hang:
        wfi
        j _hang

