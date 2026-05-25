; ============================================
; Programa 7: Multiplicacion por Sumas Sucesivas
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 07_multiplicacion.asm -o 07_multiplicacion.obj
; Enlazar:  gcc -m32 07_multiplicacion.obj -o 07_multiplicacion.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _getchar

section .data
    msg_a   db "Ingresa el multiplicando: ", 0
    msg_b   db "Ingresa el multiplicador: ", 0
    fmt_int db "%d", 0
    msg_res db "Resultado: %d x %d = %d", 10, 0

section .bss
    mult_a resd 1
    mult_b resd 1

section .text
_main:
    push ebp
    mov  ebp, esp

    push msg_a
    call _printf
    add  esp, 4

    push mult_a
    push fmt_int
    call _scanf
    add  esp, 8

    push msg_b
    call _printf
    add  esp, 4

    push mult_b
    push fmt_int
    call _scanf
    add  esp, 8

    mov  edi, [mult_a]  ; multiplicando
    mov  ecx, [mult_b]  ; multiplicador (contador)
    xor  eax, eax       ; acumulador = 0

.loop_mul:
    cmp  ecx, 0
    je   .fin_mul
    add  eax, edi
    dec  ecx
    jmp  .loop_mul

.fin_mul:
    push eax
    push dword [mult_b]
    push dword [mult_a]
    push msg_res
    call _printf
    add  esp, 16

    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
