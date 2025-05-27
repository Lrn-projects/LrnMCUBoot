MCU = esp32
SC = xtensa-esp32-elf-as
CC = xtensa-esp32-elf-gcc
LD = xtensa-esp32-elf-ld
FLASH = esptool.py
PORT = /dev/null
BAUD = 115200
SFLAGS =  
SIMULATOR = qemu-system-avr
SRCDIR = src/
OUTDIR = build/

all: init.hex

init.o: $(SRCDIR)init.s
	$(SC) $(SFLAGS) $(SRCDIR)init.s -o $(OUTDIR)init.o

init.elf: init.o
	$(CC) $(CFLAGS) $(OUTDIR)init.o -o $(OUTDIR)init.elf

init.hex: init.elf
	$(OBJCOPY) -O ihex $(OUTDIR)init.elf $(OUTDIR)init.hex

flash: init.hex
	$(FLASH) --chip $(MCU) --port $(PORT) --baud $(BAUD) write_flash 0x1000 $(OUTDIR)firmware.bin

simulate: init.elf
	$(SIMULATOR) -machine mega2560 -bios $(OUTDIR)init.elf -nographic

clean:
	rm -fv $(OUTDIR)*
