.section .data
msg:
    .ascii "Hello, asm!\n"
len = . - msg

.section .text
.global _start

_start:
    mov x8, #64         // syscall write
    mov x0, #1          // stdout
    ldr x1, =msg        // адрес строки
    ldr x2, =len        // длина
    svc #0
    bl _exit

_exit:
    mov x0, #0          // return
    mov x8, #93         // syscall exit
    svc #0
