/*
 * Copyright (c) 2021 Xing Tang. All Rights Reserved.
 */

OUTPUT_ARCH(riscv)

ENTRY(_start)

SECTIONS
{
    . = 0x80000000;
    .text :
    { 
        *(.entry)
        *(.text)
    }
    . = ALIGN(0x1000);
    /*--------------------------------------------------------------------*/
    /* HTIF, isolated onto separate page                                  */
    /*--------------------------------------------------------------------*/
    .htif :
    {
        PROVIDE( __htif_base = . );
        *(.htif)
    }
    . = ALIGN(0x1000);

    .data : { *(.data) }
    .bss : { *(.bss COMMON) }
    . = ALIGN(8);
    . = . + 0x1000; /* stack memory */
    PROVIDE(_stack = .);
}
