#
# Copyright (c) 2021. Xing Tang. All Rights Reserved.
#

TARGET = HelloRISCV.elf

CROSS_COMPILE ?= riscv64-unknown-elf-

CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
READELF         = $(CROSS_COMPILE)readelf
STRIP           = $(CROSS_COMPILE)strip


CFLAGS          = -g -Wall -Werror -nostdlib 
CFLAGS		+= -mabi=lp64 -march=rv64imafdc -mcmodel=medany

ASMOBJ = entry.o
COBJ = htif_uart.o main.o

.PHONY: all
all: $(TARGET)

$(COBJ): %.o : %.c
	$(CC) $(CFLAGS) -I. -c $< -o $@

$(ASMOBJ): %.o : %.S
	$(CC) $(CFLAGS) -I. -c $< -o $@

$(TARGET): $(COBJ) $(ASMOBJ)
	$(CC) $(CFLAGS) $(ASMOBJ) $(COBJ) -Wl,-Tlinker.ld -I. -o $@

clean:
	rm $(TARGET) $(COBJ) $(ASMOBJ) -rf
