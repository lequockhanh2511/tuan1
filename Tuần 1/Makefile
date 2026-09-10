CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
FLASH = st-flash

CFLAGS = -mcpu=cortex-m3 -mthumb -nostdlib -ffreestanding -O0
ASFLAGS = -mcpu=cortex-m3 -mthumb
LDFLAGS = -T linker.ld

RUN ?= 

all: main.bin

startup.o: startup.s
	$(AS) $(ASFLAGS) startup.s -o startup.o

main.o: $(RUN)/main.c
	$(CC) $(CFLAGS) -c $(RUN)/main.c -o main.o

main.elf: startup.o main.o linker.ld
	$(LD) $(LDFLAGS) startup.o main.o -o main.elf

main.bin: main.elf
	$(OBJCOPY) -O binary main.elf main.bin

flash: main.bin
	$(FLASH) write main.bin 0x08000000

clean:
	rm -f *.o *.elf *.bin
