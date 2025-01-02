section .data
    msg: db "Hello World!", 10
    msgSize equ $ - msg

section .text
global _start

_start:
    ;; sys_write(STDOUT=1, msg, msgSize)
    mov rax, 1           ; syscall number: sys_write
    mov rdi, 1           ; file descriptor: stdout
    mov rsi, msg         ; address of the message
    mov rdx, msgSize     ; length
    syscall

    ;; sys_exit(0)
    mov rax, 60          ; syscall number: sys_exit
    xor rdi, rdi         ; exit code 0
    syscall
