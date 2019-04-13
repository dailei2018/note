#void mul64(uint64_t a, uint64_t b, uint64_t *c, uint64_t *d);

.text
.globl	mul64

mul64:

    #保存第三个参数，因为它会被溢出覆盖
    movq    %rdx, %r12
    
    #第一个参数和第二个参数相乘
    movq    %rdi, %rax
    mulq    %rsi
    
    #把积存入第4个参数指向的内存
    movq    %rax, (%rcx)
    
    #把溢出存入第三个参数指向的内存
    movq    %rdx, (%r12)
    
    ret
