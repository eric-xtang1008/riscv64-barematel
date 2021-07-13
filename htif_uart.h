/*
 * Copyright (c) 2021 Xing Tang. All Rights Reserved.
 */
#ifndef __HTIF_UART_H__
#define __HTIF_UART_H__

#if __riscv_xlen == 64
# define TOHOST_CMD(dev, cmd, payload) \
  (((uint64_t)(dev) << 56) | ((uint64_t)(cmd) << 48) | (uint64_t)(payload))
#else
# define TOHOST_CMD(dev, cmd, payload) ({ \
  if ((dev) || (cmd)) __builtin_trap(); \
  (payload); })
#endif

void htif_init(void);
void print(const char *s);
 
#endif
