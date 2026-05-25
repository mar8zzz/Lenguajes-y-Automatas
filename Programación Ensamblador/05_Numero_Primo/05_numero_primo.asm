; ============================================
; Programa 5: Detector de Numeros Primos
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 05_numero_primo.asm -o 05_numero_primo.obj
; Enlazar:  gcc -m32 05_numero_primo.obj -o 05_numero_primo.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _getchar

section .data
    msg_input db "Ingresa un numero mayor a 1: ", 0
    fmt_int   db "%d", 0
    msg_primo db "El numero es primo", 10, 0
    msg_comp  db "El numero es compuesto", 10, 0

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

    mov  edi, [numero]

    cmp  edi, 2
    jl   .compuesto
    je   .primo

    mov  ecx, 2         ; divisor = 2

.loop_primo:
    ; Si divisor^2 > numero -> es primo
    mov  eax, ecx
    imul eax, ecx
    cmp  eax, edi
    jg   .primo

    mov  eax, edi
    xor  edx, edx
    div  ecx
    test edx, edx
    jz   .compuesto

    inc  ecx
    jmp  .loop_primo

.primo:
    push msg_primo
    call _printf
    add  esp, 4
    jmp  .fin

.compuesto:
    push msg_comp
    call _printf
    add  esp, 4

.fin:
    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
