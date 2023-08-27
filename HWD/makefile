# sample makefile
all:hw6.c idiv.s bin2bcd.s bcdadd.s bcdsub.s
	arm-none-eabi-gcc -g -O0 hw6.c idiv.s bin2bcd.s bcdadd.s bcdsub.s -o hw6.exe
gbd:
	arm-none-eabi-insight
clean:
	rm -f hw6.exe
