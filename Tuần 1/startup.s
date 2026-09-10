.syntax unified
.cpu cortex-m3
.thumb

.section .isr_vector, "a"
.word _estack
.word Reset_Handler
.word Default_Handler
.word Default_Handler
.space 4*(16-3)

.section .text
.thumb_func
.global Reset_Handler

Reset_Handler:
ldr r0, =_sidata
ldr r1, =_sdata
ldr r2, =_edata

copy_data:
cmp r1, r2
bge copy_done
ldr r3, [r0], #4
str r3, [r1], #4
b copy_data

copy_done:
ldr r1, =_sbss
ldr r2, =_ebss
movs r3, #0

zero_bss:
cmp r1, r2
bge zero_done
str r3, [r1], #4
adds r1, r1, #0
b zero_bss

zero_done:
bl main
b .

.thumb_func

Default_Handler:
b .
