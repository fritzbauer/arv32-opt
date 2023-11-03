all:
	avr-gcc -c -mmcu=atmega328p -I. -DF_CPU=16000000UL  -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -Wa,-adhlns=main.lst  -std=gnu99 main.c -o main.o
	avr-gcc -c -mmcu=atmega328p -I. -DF_CPU=16000000UL  -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -Wa,-adhlns=sdcard.lst  -std=gnu99 sdcard.c -o sdcard.o
	avr-gcc -c -mmcu=atmega328p -I. -DF_CPU=16000000UL  -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -Wa,-adhlns=sdprint.lst  -std=gnu99 sdprint.c -o sdprint.o
	avr-gcc -c -mmcu=atmega328p -I. -DF_CPU=16000000UL  -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -Wa,-adhlns=spi.lst  -std=gnu99 spi.c -o spi.o
	avr-gcc -c -mmcu=atmega328p -I. -DF_CPU=16000000UL  -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -Wa,-adhlns=uart.lst  -std=gnu99 uart.c -o uart.o
	avr-gcc -mmcu=atmega328p -I. -DF_CPU=16000000UL -O3 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -Wall -Wstrict-prototypes -std=gnu99 main.o sdcard.o sdprint.o spi.o uart.o --output main.elf -Wl,-Map=main.map,--cref
	avr-objcopy -O ihex -R .eeprom main.elf main.hex
	avr-size -A -d main.elf

install:
	avrdude -v -V -patmega328p -carduino -P /dev/ttyACM0 -b115200 -D "-Uflash:w:main.hex:i"

preparesd:
	dd if=./rv32.bin of=/dev/sdc conv=notrunc

clean:
	rm main.hex main.elf *.o