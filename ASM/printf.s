global  main          ;
extern  printf        ;

section .data
    hello_msg   db  "Hello, world!", 10, 0   ;

section .text

; ----------------------------------
; int main(void)
; {
;     printf("Hello, world!");
;     return 0;
; }
; ----------------------------------
main:
    ; prologue
    push    rbp         ;
    mov     rbp, rsp    ;

    ; printf("Hello, world!");
    lea     rdi, [rel hello_msg]
    xor     eax, eax

    call    printf wrt ..plt

    ; return 0
    mov     eax, 0

    ; epilogue
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
