MCU = atmega4809
CC = avr-gcc
OBJCOPY = avr-objcopy
CFLAGS = -mmcu=$(MCU) -nostartfiles -Os
SIMULATOR = qemu-system-avr
SRCDIR = src/
OUTDIR = build/

all: init.hex

init.o: $(SRCDIR)init.s
	$(CC) $(CFLAGS) -c $(SRCDIR)init.s -o $(OUTDIR)init.o

init.elf: init.o
	$(CC) $(CFLAGS) $(OUTDIR)init.o -o $(OUTDIR)init.elf

init.hex: init.elf
	$(OBJCOPY) -O ihex $(OUTDIR)init.elf $(OUTDIR)init.hex

flash: init.hex
	avrdude -c <PROGRAMMER> -p $(MCU) -U flash:w:init.hex

simulate: init.elf
	$(SIMULATOR) -machine mega2560 -bios $(OUTDIR)init.elf -nographic

clean:
	rm -f $(OUTDIR)*
