MCU = esp32
# ---------------asm compilation----------------------
SC = xtensa-esp32-elf-as
SFLAGS = --warn --fatal-warnings 
# ---------------C compilation------------------------
CC = xtensa-esp32-elf-gcc
# add -c flag to compile and assemble but not link to avoid _start duplication
CCFLAGS = -c
# ---------------Linking------------------------------
LD = xtensa-esp32-elf-ld
LINKERFILE = linker.ld
# ---------------object copy--------------------------
OBJCOPY = xtensa-esp32-elf-objcopy
OBJCOPYFLAGS = -O binary
# ---------------flash--------------------------------
FLASH = esptool.py
PORT = /dev/null
BAUD = 115200
# ---------------emulation----------------------------
EMULATOR = qemu-system-avr
# ---------------src and build dir var----------------
SRCDIR = src/
OUTDIR = build/

all: boot.bin

# compile asm file
init.o: $(SRCDIR)init.s
	$(SC) $(SFLAGS) $(SRCDIR)init.s -o $(OUTDIR)init.o

# compile C files
main.o: $(SRCDIR)main.c
	$(CC) $(CCFLAGS) $(SRCDIR)main.c -o $(OUTDIR)main.o

# link C and asm
boot.elf: init.o main.o
	$(LD) $(OUTDIR)init.o $(OUTDIR)main.o -T $(LINKERFILE) -o $(OUTDIR)boot.elf

# objcopy 
boot.bin: boot.elf
	$(OBJCOPY) $(OBJCOPYFLAGS) $(OUTDIR)boot.elf $(OUTDIR)boot.bin

# flash
flash: boot.bin
	$(FLASH) --chip $(MCU) --port $(PORT) --baud $(BAUD) write_flash 0x1000 $(OUTDIR)firmware.bin

# emulation
emulate: boot.elf
	$(EMULATOR) -machine mega2560 -bios $(OUTDIR)init.elf -nographic

clean:
	rm -fv $(OUTDIR)*
