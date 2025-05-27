MCU = esp32
SC = xtensa-esp32-elf-as
CC = xtensa-esp32-elf-gcc
# add -c flag to compile and assemble but not link to avoid _start duplication
CCFLAGS = -c
LD = xtensa-esp32-elf-ld
LINKERFILE = linker.ld
OBJCOPY = xtensa-esp32-elf-objcopy
OBJCOPYFLAGS = -O binary
FLASH = esptool.py
PORT = /dev/null
BAUD = 115200
SFLAGS = --warn --fatal-warnings 
SIMULATOR = qemu-system-avr
SRCDIR = src/
OUTDIR = build/

all: boot.bin

init.o: $(SRCDIR)init.s
	$(SC) $(SFLAGS) $(SRCDIR)init.s -o $(OUTDIR)init.o

main.o: $(SRCDIR)main.c
	$(CC) $(CCFLAGS) $(SRCDIR)main.c -o $(OUTDIR)main.o

boot.elf: init.o main.o
	$(LD) $(OUTDIR)init.o $(OUTDIR)main.o -T $(LINKERFILE) -o $(OUTDIR)boot.elf

boot.bin: boot.elf
	$(OBJCOPY) $(OBJCOPYFLAGS) $(OUTDIR)boot.elf $(OUTDIR)boot.bin

flash: boot.bin
	$(FLASH) --chip $(MCU) --port $(PORT) --baud $(BAUD) write_flash 0x1000 $(OUTDIR)firmware.bin

simulate: boot.elf
	$(SIMULATOR) -machine mega2560 -bios $(OUTDIR)init.elf -nographic

clean:
	rm -fv $(OUTDIR)*
