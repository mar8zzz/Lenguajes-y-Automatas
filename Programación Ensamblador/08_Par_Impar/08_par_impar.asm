; ============================================
; Programa 8: Identificador de Par o Impar
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 08_par_impar.asm -o 08_par_impar.obj
; Enlazar:  gcc -m32 08_par_impar.obj -o 08_par_impar.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _getchar

section .data
    msg_input db "Ingresa un numero entero: ", 0
    fmt_int   db "%d", 0
    msg_par   db "Es par", 10, 0
    msg_impar db "Es impar", 10, 0

section .bss
    numero resd 1

section .text
_main:
    push ebp
    mov  ebp, esp

    push msg_input
    call _printf
    add  esp, 4

    push numero
    push fmt_int
    call _scanf
    add  esp, 8

    mov  eax, [numero]

    ; Mascara AND con 1 (bit menos significativo)
    and  eax, 1
    jnz  .impar

.par:
    push msg_par
    call _printf
    add  esp, 4
    jmp  .fin

.impar:
    push msg_impar
    call _printf
    add  esp, 4

.fin:
    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
