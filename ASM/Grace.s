; This program will print its own source when run.
%define NEWLINE 10
%define DOUBLE_QUOTE 34
%macro MAIN 0
global  main
extern  dprintf

section .rodata
    src   db  "; This program will print its own source when run.%1$c%%define NEWLINE 10%1$c%%define DOUBLE_QUOTE 34%1$c%%macro MAIN 0%1$cglobal  main%1$cextern  dprintf%1$c%1$csection .rodata%1$c    src   db  %2$c%3$s%2$c, 0%1$c    file  db  %2$cGrace_kid.s%2$c, 0%1$c%1$csection .text%1$cfoo:%1$c    push rbp%1$c    mov rbp, rsp%1$c    leave%1$c    ret%1$cmain:%1$c    push    rbp%1$c    mov     rbp, rsp%1$c    sub     rsp, 0x10%1$c    %1$c    mov rdi, -100%1$c    lea rsi, [rel file]%1$c    mov rdx, (0o100|0o01|0o1000)%1$c    mov r10, 0o644%1$c    mov rax, 0x101%1$c    syscall%1$c    mov     [rbp-0x8], rax%1$c    %1$c    mov     rdi, rax%1$c    lea     rsi, [rel src]%1$c    mov     rdx, NEWLINE%1$c    mov     rcx, DOUBLE_QUOTE%1$c    lea     r8, [rel src]%1$c    xor     eax, eax%1$c    call    dprintf wrt ..plt%1$c    %1$c    mov     rdi, [rbp-0x8]%1$c    mov     rax, 0x3%1$c    syscall%1$c    %1$c    mov     eax, 0%1$c    %1$c    leave%1$c    ret%1$c%1$csection .note.GNU-stack noalloc noexec nowrite progbits%1$c%%endmacro%1$c%1$cMAIN%1$c", 0
    file  db  "Grace_kid.s", 0

section .text
foo:
    push rbp
    mov rbp, rsp
    leave
    ret
main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10
    
    mov rdi, -100
    lea rsi, [rel file]
    mov rdx, (0o100|0o01|0o1000)
    mov r10, 0o644
    mov rax, 0x101
    syscall
    mov     [rbp-0x8], rax
    
    mov     rdi, rax
    lea     rsi, [rel src]
    mov     rdx, NEWLINE
    mov     rcx, DOUBLE_QUOTE
    lea     r8, [rel src]
    xor     eax, eax
    call    dprintf wrt ..plt
    
    mov     rdi, [rbp-0x8]
    mov     rax, 0x3
    syscall
    
    mov     eax, 0
    
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
%endmacro

MAIN
