
OUTPUT_ARCH( "riscv" ) 
ENTRY(_start)

MEMORY
{
    FLASH (rx) : ORIGIN = 0x80000000, LENGTH = 512K
    RAM (rwx)  : ORIGIN = 0x80080000, LENGTH = 512K
}

SECTIONS
{
    . = 0x80000000; /* Start address for the program */

    .text : {
        *(.text)
        *(.text.*)
    } > FLASH

    . = ALIGN(3);
    .rodata : {
        *(.rodata)
        *(.rodata.*)
    } > FLASH

    . = ALIGN(3);
    _end = .;
    .data : {
        *(.data)
        *(.data.*)
    } > RAM 

    . = ALIGN(3);
    .bss : {
        *(.bss)
        *(.bss.*)
        *(COMMON)
    } > RAM

    .tohost : {
        *(.tohost)
    } > RAM AT > FLASH

   . = ALIGN(3);
    _end = .; 

    /DISCARD/ : { *(.eh_frame) *(.comment) }
}

