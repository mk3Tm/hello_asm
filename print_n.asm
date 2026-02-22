.section .data

.section .text
.global _start

_start:
    mov x1, #10
    mov x2, #5

    mov x0, x1
    bl print_number

    mov x0, '+'
    bl print_char

    mov x0, x2
    bl print_number

    mov x0, '='
    bl print_char

    add x0, x1, x2
    bl print_number

 // mov x0, 'a'
 // bl print_char

    bl new_line

    bl exit

print_number:               //input x0 - dividend
    stp x1, x0, [sp, -16]!
    stp x3, x2, [sp, -16]!
    sub sp, sp, #16
    str x30, [sp]

    mov x3, #0

    .next_iter:

    add x3, x3, #1
    bl remainder
    add x1, x1, '0'

    sub sp, sp, #16
    str x1, [sp]

    cmp x0, #0
    b.eq .print_digit

        b .next_iter

    .print_digit:
    sub x3, x3, #1

    ldr x1, [sp]
    add sp, sp, #16

    mov x0, x1
    bl print_char

    cmp x3, #0
    b.eq .close
        b .print_digit
    
    .close:
    ldr x30, [sp]
    add sp, sp, #16
    ldp x3, x2, [sp], 16
    ldp x1, x0, [sp], 16

    ret

remainder:                  // input x0 - dividend (589)
    stp x30, x2, [sp, -16]!

    mov x2, #10             // divisor
    udiv x1, x0, x2         // x1 = quotient (58)
    mul  x2, x1, x2         // x2 = 58 * 10 = 580
    sub  x2, x0, x2         // x2 = 589 - 580 = 9

    mov x0, x1
    mov x1, x2

    ldp x30, x2, [sp], 16

    ret

print_char:                 // input x0 - char
    stp x1, x2, [sp, -16]!
    stp x0, x8, [sp, -16]!

    mov x0, #1
    mov x1, sp
    mov x2, #1
    mov x8, #64
    svc #0

    ldp x0, x8, [sp], 16
    ldp x1, x2, [sp], 16
    
    ret

new_line:
    stp x0, x30, [sp, -16]!

    mov x0, '\n'
    bl print_char

    ldp x0, x30, [sp], 16

    ret

exit:
    mov x0, #0
    mov x8, #93
    svc #0
