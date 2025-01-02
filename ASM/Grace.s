; This program will print its own source when run.
%define NEWLINE 10
%define DOUBLE_QUOTE 34
%macro MAIN 0
global  main
extern  printf

section .data
    src   db  "; This program will print its own source when run.%1$c%%define NEWLINE 10%1$c%%define DOUBLE_QUOTE 34%1$c%%macro MAIN 0%1$cglobal  main%1$cextern  printf%1$c%1$csection .data%1$c    src   db  %2$c%3$s%2$c, 0%1$c%1$csection .text%1$cfoo:%1$c    push rbp%1$c    mov rbp, rsp%1$c    pop rbp%1$c    ret%1$cmain:%1$c    push    rbp         ;%1$c    mov     rbp, rsp    ;%1$c%1$c    call foo%1$c%1$c    lea     rdi, [rel src]%1$c    mov     rsi, NEWLINE%1$c    mov     rdx, DOUBLE_QUOTE%1$c    lea     rcx, [rel src]%1$c    xor     eax, eax%1$c    call    printf wrt ..plt%1$c%1$c    mov     eax, 0%1$c%1$c    leave%1$c    ret%1$c%1$csection .note.GNU-stack noalloc noexec nowrite progbits%1$c%%endmacro%1$c%1$cMAIN%1$c", 0

section .text
foo:
    push rbp
    mov rbp, rsp
    pop rbp
    ret
main:
    push    rbp         ;
    mov     rbp, rsp    ;

    call foo

    lea     rdi, [rel src]
    mov     rsi, NEWLINE
    mov     rdx, DOUBLE_QUOTE
    lea     rcx, [rel src]
    xor     eax, eax
    call    printf wrt ..plt

    mov     eax, 0

    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
%endmacro

MAIN
