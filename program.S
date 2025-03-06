.section .text
.globl _start

_start:
    addi x1, x0, 5    # x1 = 5
    addi x2, x0, 10   # x2 = 10
    add x3, x1, x2    # x3 = x1 + x2
    sub x4, x2, x1    # x4 = x2 - x1
    and x5, x1, x2    # x5 = x1 & x2
    or x6, x1, x2     # x6 = x1 | x2
    xor x7, x1, x2    # x7 = x1 ^ x2
    sll x8, x1, x2    # x8 = x1 << x2
    srl x9, x1, x2    # x9 = x1 >> x2
    beq x1, x2, END   # If x1 == x2, jump to END
    j _start          # Infinite loop to keep execution

END:
    nop               # No operation (halt simulation)
