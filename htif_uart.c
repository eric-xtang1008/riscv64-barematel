/*
 * Copyright (c) 2021. Xing Tang. All Rights Reserved.
 */

#include "types.h"
#include "htif_uart.h"

/*
 * HTIF is the Host/Target Interface.
 *
 *        63       56|55     48|47            0
 *        -------------------------------------
 *        |  device  | command |     data     |
 *        -------------------------------------
 *
 *  device=0 --- syscall
 *           --- command=0, data = pointer to syscall
 *           --- command=1, data = exit code
 *
 *  device=1 --- a blocking character device
 *           --- command=0, read a character
 *           --- command=1, write a character
 */

volatile uint64_t tohost __attribute__((section(".htif")));
volatile uint64_t fromhost __attribute__((section(".htif")));

static void send_tohost(uintptr_t dev, uintptr_t cmd, uintptr_t data)
{
    while (tohost); /* wait the data be fetched by host */

    tohost = TOHOST_CMD(dev, cmd, data);
}

static void htif_console_putchar(uint8_t ch)
{
    send_tohost(1, 1, ch);
}

void print(const char *s) {
     while(*s != '\0')
         htif_console_putchar(*s++);
}

void htif_init(void)
{
  tohost = 0;
  fromhost = 0;
}
