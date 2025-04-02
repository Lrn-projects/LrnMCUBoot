MCU = atmega4809
CC = avr-gcc
OBJCOPY = avr-objcopy
CFLAGS = -mmcu=$(MCU) -nostartfiles -Os
SIMULATOR = simavr
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
	$(SIMULATOR) -m $(MCU) -f 1000000 $(OUTDIR)init.elf

clean:
	rm -f $(OUTDIR)*
