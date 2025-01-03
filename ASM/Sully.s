; This program will write a copy of its own source code to a file named Sully_X.s, where X is the number of times the program has been run.
%define NEWLINE 10
%define DOUBLE_QUOTE 34
%macro MAIN 0
global  main
extern  dprintf, sprintf, system, execv

section .rodata
    src   db  "; This program will write a copy of its own source code to a file named Sully_X.s, where X is the number of times the program has been run.%1$c%%define NEWLINE 10%1$c%%define DOUBLE_QUOTE 34%1$c%%macro MAIN 0%1$cglobal  main%1$cextern  dprintf, sprintf, system, execv%1$c%1$csection .rodata%1$c    src   db  %2$c%3$s%2$c, 0%1$c    filename_format  db  %2$cSully_%%d.s%2$c, 0%1$c    cmd_format  db  %2$cnasm -f elf64 -o Sully_%%1$d.o Sully_%%1$d.s && gcc -o Sully_%%1$d Sully_%%1$d.o%2$c, 0%1$c    execpath_format  db  %2$cSully_%%d%2$c, 0%1$c%1$csection .bss%1$c    filename   resb 32%1$c    cmd        resb 128%1$c    execpath   resb 32%1$c%1$csection .text%1$cmain:%1$c    ; Function prologue%1$c    push    rbp%1$c    mov     rbp, rsp%1$c    ; Allocate space for local variables (int i, int fd): Total 8 bytes%1$c    sub     rsp, 0x8%1$c%1$c    mov     dword [rbp-0x4], %4$d   ; int i = %4$d%1$c    sub     dword [rbp-0x4], 1   ; i--%1$c    mov     dword [rbp-0x8], 0   ; int fd = 0;%1$c%1$c    ; char filename[32]; sprintf(filename, %2$cSully_%%d.s%2$c, i)%1$c    lea	    rdi, [rel filename]	        ; filename%1$c    lea     rsi, [rel filename_format]  ; use relative addressing for PIC%1$c    mov     rdx, [rbp-0x4]              ; i%1$c    xor     eax, eax                    ; to tell printf that we don't have floating point arguments%1$c    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC%1$c%1$c    ; char cmd[128]; sprintf(cmd, %2$cnasm -f elf64 -o Sully_%%1$d.o Sully_%%1$d.s && gcc -o Sully_%%1$d Sully_%%1$d.o%2$c, i)%1$c    lea	    rdi, [rel cmd]	            ; cmd%1$c    lea     rsi, [rel cmd_format]       ; use relative addressing for PIC%1$c    mov     rdx, [rbp-0x4]              ; i%1$c    xor     eax, eax                    ; to tell printf that we don't have floating point arguments%1$c    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC%1$c%1$c    ; char execpath[32]; sprintf(execpath, %2$cSully_%%d%2$c, i)%1$c    lea     rdi, [rel execpath]         ; execpath%1$c    lea     rsi, [rel execpath_format]  ; use relative addressing for PIC%1$c    mov     rdx, [rbp-0x4]              ; i%1$c    xor     eax, eax                    ; to tell printf that we don't have floating point arguments%1$c    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC%1$c%1$c    ; int fd = open_at(AT_FDCWD, file, O_WRONLY|O_CREAT|O_TRUNC, 0644)%1$c    mov rdi, -100                       ; AT_FDCWD%1$c    lea rsi, [rel filename]             ; use relative addressing for PIC%1$c    mov rdx, (0o100|0o01|0o1000)        ; O_WRONLY|O_CREAT|O_TRUNC%1$c    mov r10, 0o644			            ; 0644%1$c    mov rax, 0x101 			            ; syscall number for openat%1$c    syscall%1$c    mov dword [rbp-0x8], eax            ; Save the file descriptor (4 bytes)%1$c%1$c    ; dprintf(fd, src, NEWLINE, DOUBLE_QUOTE, src, i)%1$c    mov     edi, [rbp-0x8]              ; file descriptor (4 bytes)%1$c    lea     rsi, [rel src]%1$c    mov     rdx, NEWLINE%1$c    mov     rcx, DOUBLE_QUOTE%1$c    lea     r8, [rel src]%1$c    mov     r9d, [rbp-0x4]              ; i%1$c    xor     eax, eax  		            ; to tell dprintf that we don't have floating point arguments%1$c    call    dprintf wrt ..plt           ; wrt ..plt is needed for PIC%1$c%1$c    ; close(fd)%1$c    mov     rdi, [rbp-0x8]              ; Restore the file descriptor%1$c    mov     rax, 0x3	                ; syscall number for close%1$c    syscall%1$c%1$c    ; if (i < 0) return -1%1$c    cmp     dword [rbp-0x4], 0%1$c    jge     .next%1$c    mov     eax, -1                     ; return -1%1$c    leave                               ; restore the stack frame%1$c    ret%1$c%1$c.next:%1$c    ; system(cmd)%1$c    lea     rdi, [rel cmd]%1$c    call    system wrt ..plt            ; wrt ..plt is needed for PIC%1$c%1$c    ; execv(execpath, NULL)%1$c    lea     rdi, [rel execpath]%1$c    xor     rsi, rsi%1$c    call    execv wrt ..plt             ; wrt ..plt is needed for PIC%1$c%1$c    ; return 0%1$c    mov     eax, 0%1$c%1$c    ; Function epilogue%1$c    leave                               ; restore the stack frame%1$c    ret%1$c%1$c; This section is needed to prevent the program from being placed on the stack and suppresses the warning%1$csection .note.GNU-stack noalloc noexec nowrite progbits%1$c%%endmacro%1$c%1$cMAIN%1$c", 0
    filename_format  db  "Sully_%d.s", 0
    cmd_format  db  "nasm -f elf64 -o Sully_%1$d.o Sully_%1$d.s && gcc -o Sully_%1$d Sully_%1$d.o", 0
    execpath_format  db  "Sully_%d", 0

section .bss
    filename   resb 32
    cmd        resb 128
    execpath   resb 32

section .text
main:
    ; Function prologue
    push    rbp
    mov     rbp, rsp
    ; Allocate space for local variables (int i, int fd): Total 8 bytes
    sub     rsp, 0x8

    mov     dword [rbp-0x4], 5   ; int i = 5
    sub     dword [rbp-0x4], 1   ; i--
    mov     dword [rbp-0x8], 0   ; int fd = 0;

    ; char filename[32]; sprintf(filename, "Sully_%d.s", i)
    lea	    rdi, [rel filename]	        ; filename
    lea     rsi, [rel filename_format]  ; use relative addressing for PIC
    mov     rdx, [rbp-0x4]              ; i
    xor     eax, eax                    ; to tell printf that we don't have floating point arguments
    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC

    ; char cmd[128]; sprintf(cmd, "nasm -f elf64 -o Sully_%1$d.o Sully_%1$d.s && gcc -o Sully_%1$d Sully_%1$d.o", i)
    lea	    rdi, [rel cmd]	            ; cmd
    lea     rsi, [rel cmd_format]       ; use relative addressing for PIC
    mov     rdx, [rbp-0x4]              ; i
    xor     eax, eax                    ; to tell printf that we don't have floating point arguments
    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC

    ; char execpath[32]; sprintf(execpath, "Sully_%d", i)
    lea     rdi, [rel execpath]         ; execpath
    lea     rsi, [rel execpath_format]  ; use relative addressing for PIC
    mov     rdx, [rbp-0x4]              ; i
    xor     eax, eax                    ; to tell printf that we don't have floating point arguments
    call    sprintf wrt ..plt           ; wrt ..plt is needed for PIC

    ; int fd = open_at(AT_FDCWD, file, O_WRONLY|O_CREAT|O_TRUNC, 0644)
    mov rdi, -100                       ; AT_FDCWD
    lea rsi, [rel filename]             ; use relative addressing for PIC
    mov rdx, (0o100|0o01|0o1000)        ; O_WRONLY|O_CREAT|O_TRUNC
    mov r10, 0o644			            ; 0644
    mov rax, 0x101 			            ; syscall number for openat
    syscall
    mov dword [rbp-0x8], eax            ; Save the file descriptor (4 bytes)

    ; dprintf(fd, src, NEWLINE, DOUBLE_QUOTE, src, i)
    mov     edi, [rbp-0x8]              ; file descriptor (4 bytes)
    lea     rsi, [rel src]
    mov     rdx, NEWLINE
    mov     rcx, DOUBLE_QUOTE
    lea     r8, [rel src]
    mov     r9d, [rbp-0x4]              ; i
    xor     eax, eax  		            ; to tell dprintf that we don't have floating point arguments
    call    dprintf wrt ..plt           ; wrt ..plt is needed for PIC

    ; close(fd)
    mov     rdi, [rbp-0x8]              ; Restore the file descriptor
    mov     rax, 0x3	                ; syscall number for close
    syscall

    ; if (i < 0) return -1
    cmp     dword [rbp-0x4], 0
    jge     .next
    mov     eax, -1                     ; return -1
    leave                               ; restore the stack frame
    ret

.next:
    ; system(cmd)
    lea     rdi, [rel cmd]
    call    system wrt ..plt            ; wrt ..plt is needed for PIC

    ; execv(execpath, NULL)
    lea     rdi, [rel execpath]
    xor     rsi, rsi
    call    execv wrt ..plt             ; wrt ..plt is needed for PIC

    ; return 0
    mov     eax, 0

    ; Function epilogue
    leave                               ; restore the stack frame
    ret

; This section is needed to prevent the program from being placed on the stack and suppresses the warning
section .note.GNU-stack noalloc noexec nowrite progbits
%endmacro

MAIN
