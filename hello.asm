.section .data
msg:
    .string "Hello, asm!\n"

.section .text
.global _start

_start:
    ldr x1, =msg            // адрес строки
    bl print_string
 // bl print_string
    bl exit

print_string:
    sub sp, sp, #16
    str x30, [sp]           // push
    stp x0, x2, [sp, -16]!  // x30 - LR
    bl lenght_string
    mov x0, #1              // fd = stdout
    mov x8, #64             // syscall write
    svc #0
    ldp x0, x2, [sp], 16    // pop
    ldr x30, [sp]
    add sp, sp, #16
    ret

lenght_string:              // input string
    mov x2, #0
    .next_iter:
        ldrb w0, [x1, x2]   // w0 = str[x0 + x1]
        cmp w0, #0          // if(w0 == '/0')
        beq .close
        add x2, x2, #1      // inc
        b .next_iter
    .close:
        ret

exit:
    mov x0, #0              // return
    mov x8, #93             // syscall exit
    svc #0
