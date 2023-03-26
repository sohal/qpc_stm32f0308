__flash = 0x08000000;   /* starting address of flash */
__flash_size = 0x10000; /* length of flash */
__ram = 0x20000000;     /* starting address of RAM bank 0 */
__ram_size = 0x2000;    /* length of RAM bank 0 */
__stack_size = 0x400;

INCLUDE picolibc.ld
