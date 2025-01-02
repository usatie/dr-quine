; This program will write its own source to a file named Grace_kid.s
%define NEWLINE 10
%define DOUBLE_QUOTE 34
%macro MAIN 0
global  main
extern  dprintf

section .rodata
    src   db  "<source code>", 0
    file  db  "Grace_kid.s", 0

section .text
foo:
	; Function prologue
    push rbp
    mov rbp, rsp
	; Function epilogue
    pop rbp
    ret
main:
	; Function prologue
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10            ; Allocate space for local variables
    
	; int fd = open_at(AT_FDCWD, file, O_WRONLY|O_CREAT|O_TRUNC, 0644)
    mov rdi, -100                ; AT_FDCWD
    lea rsi, [rel file]          ; use relative addressing for PIC
    mov rdx, (0o100|0o01|0o1000) ; O_WRONLY|O_CREAT|O_TRUNC
    mov r10, 0o644			     ; 0644
    mov rax, 0x101 			     ; syscall number for openat
    syscall
    mov     [rbp-0x8], rax
    
	; dprintf(fd, src, NEWLINE, DOUBLE_QUOTE, src)
    mov     rdi, rax
    lea     rsi, [rel src]
    mov     rdx, NEWLINE
    mov     rcx, DOUBLE_QUOTE
    lea     r8, [rel src]
    xor     eax, eax
    call    dprintf wrt ..plt    ; wrt ..plt is needed for PIC
    
	; close(fd)
    mov     rdi, [rbp-0x8]       ; Restore the file descriptor
    mov     rax, 0x3	         ; syscall number for close
    syscall
    
	; return 0
    mov     eax, 0
    
	; Function epilogue
    leave                        ; restore the stack frame
    ret

; This section is needed to prevent the program from being placed on the stack and suppresses the warning
section .note.GNU-stack noalloc noexec nowrite progbits
%endmacro

MAIN
