# LrnMCUBoot

A bootloader to load a firmware from flash memory on an ATMEGA4809 chip.

## Goal

The goal of the project is to understand how a MCU load without an OS, to write a bootloader that will load a firmware from flash memory and manage the update of the firmware.

## Chip specs

The ATmega4809 is a low-power microcontroller from Microchip Technology Inc. It is part of the AVR family and is designed for a wide range of applications, including consumer electronics, automotive, and industrial control systems.

Here are some key specifications of the ATmega4809:

- Microcontroller: ATmega4809
- Architecture: AVR 8-bit

Memory:

- Flash 48KB
- SRAM 6 KB
- EEPROMB 256B
- User row 64B

Pheripherals:

- Pins 48
- Max. frequency 20MHz
- 16-bit Timer/Counter type A (TCA) 1
- 16-bit Timer/Counter type B (TCB) 4
- Real-Time Counter (RTC) 1
- USART 4
- SPI 1
