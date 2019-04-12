#[reference]
#https://en.wikibooks.org/wiki/X86_Assembly/GAS_Syntax#cite_note-1


movb  src  dst

#后缀
#如果没有带后缀，gas会根据 dst 的大小来推断
b = byte (8 bit)
s = single (32 bit floating point)
w = word (16 bit)
l = long (32 bit integer or 64 bit floating point)
q = quad (64 bit)
t = tem bytes (80 bit floating point)


#前缀
#寄存器需要带上 % ，常数需要带上 $
movb $0xff %al

#对内存的简洁引用带上()
movb (%esi), %al        # %esi 指针指向的内存中一个字节存入 %al

#地址操作语法
movl    -8(%ebp, %edx, 4), %eax  # Full example: load *(ebp + (edx * 4) - 8) into eax
movl    -4(%ebp), %eax           # Typical example: load a stack variable into eax
movl    (%ecx), %edx             # No index: copy the target of a pointer into a register
leal    8(,%eax,4), %eax         # Arithmetic: multiply eax by 4 and add 8
leal    (%edx,%eax,2), %eax      # Arithmetic: multiply eax by 2 and add edx


movq %rax, %rbx	            rbx = rax
movq $123, %rax	            rax = 123
movq %rsi, -16(%rbp)	    mem[rbp-16] = rsi
subq $10, %rbp	            rbp = rbp -10
cmpl %eax %ebx	            compare then set flags. If eax == ebx, zero flag is set.
jmp <location>	            unconditional jump
je <location>	            jump to <location> if equal flag is set
jg,jge,jl,jle,jne,...	    >,>=,<,<=,!=,...


[函数调用约定]
https://en.wikibooks.org/wiki/X86_Disassembly/Calling_Conventions

函数参数从左到右：
    整数和指针 rdi, rsi, rdx, rcx, r8, r9
    浮点 xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7
    
    额外的参数会压入栈， 从右到左压入，在调用完毕后由调用者移除
    在参数被压入栈之后，调用的函数获得了控制权，返回地址在 %rsp，第一个内存参数在 8(%rsp)
    在调用函数之前，%rsp 必须16字节对齐，程序调用函数，会把返回地址(8 bytes)压入栈，所以当
    函数得到控制时，%rsp 并没有对齐，必须手动对齐，比如%rsp - 8。
    
    在调用函数时，这几个寄存器需要调用者自己保存 rbp, rbx, r12, r13, r14, r15
    整数在 rax or rdx:rax 返回，浮点数在 xmm0 or xmm1:xmm0

#寄存器
sp          栈指针


#指令
ret         弹出栈中的数据到IP，相当于 pop IP - 段内指令转移
retf        弹出栈中的IP,CS(段)，相当于 pop IP,pop CS  - 段外指令转移

call        将当前IP(或者CS+IP)压入栈中，跳转执行相应的指令






gcc 内联汇编


[约束]
输出操作数约束应该带有一个约束修饰符 "="
当使用 "r" 约束时，GCC 在这里可以自由分配任何寄存器

a   %eax
b   %ebx
c   %ecx
d   %edx
S   %esi
D   %edi