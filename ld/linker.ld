/* 1. Define the entry point of the application */
ENTRY(Reset_Handler)

/* 2. Define the physical memory layout of the chip */
MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 512K
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

/* 3. Calculate the initial Stack Pointer (Top of RAM) */
_estack = ORIGIN(RAM) + LENGTH(RAM);

/* 4. Minimum required size for the Heap and Stack (for safety checks) */
_Min_Heap_Size  = 0x200;  /* 512 bytes */
_Min_Stack_Size = 0x400;  /* 1024 bytes */

/* 5. Map the compiled code sections into the memory regions */
SECTIONS
{
  /* The Vector Table and program code go into FLASH */
  .text :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Keep vector table; don't let garbage collection remove it */
    *(.text)             /* Program code instructions */
    *(.text*)            /* Sub-sections of code */
    *(.rodata)           /* Read-only data (constants, string literals) */
    *(.rodata*)
    . = ALIGN(4);
    _etext = .;          /* Memory marker: End of FLASH code execution area */
  } > FLASH

  /* Used by the startup code to initialize the .data section in RAM */
  _sidata = LOADADDR(.data);

  /* Initialized global/static variables (VMA is RAM, but LMA is FLASH) */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;          /* Memory marker: Start of RAM data section */
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;          /* Memory marker: End of RAM data section */
  } > RAM AT> FLASH

  /* Uninitialized global/static variables (zero-initialized on boot) */
  .bss :
  {
    . = ALIGN(4);
    _sbss = .;           /* Memory marker: Start of BSS section */
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;           /* Memory marker: End of BSS section */
  } > RAM

  /* Dynamic memory allocation (Heap) area */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } > RAM

  /* Discard debugging sections that aren't needed on the chip */
  /DISCARD/ :
  {
    *(.note.GNU-stack)
    *(.gnu_debuglink)
    *(.gnu.lto_*)
  }
}

