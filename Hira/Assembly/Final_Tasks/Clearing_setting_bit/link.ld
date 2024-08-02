OUTPUT_ARCH( "riscv" )
ENTRY( _start )
SECTIONS
{
 . = 0x10000; /* Start address for the text section */
 .text : { *(.text) }
 .data : { *(.data) }
 .bss : { *(.bss) }
 .tohost : { *(.tohost) }
}
