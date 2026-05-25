; ============================================
; Programa 1: Generador de Piramide Centrada (CORREGIDO)
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 01_piramide.asm -o 01_piramide.obj
; Enlazar:  gcc -m32 01_piramide.obj -o 01_piramide.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _system

section .data
    msg_input   db "Ingresa el numero de filas (1-9): ", 0
    fmt_input   db "%d", 0
    fmt_espacio db " ", 0
    fmt_ast     db "*", 0
    fmt_newline db 10, 0
    pause_cmd   db "pause", 0

section .bss
    filas resd 1

section .text
_main:
    push ebp
    mov  ebp, esp

    ; Pedir numero de filas
    push msg_input
    call _printf
    add  esp, 4

    ; Leer numero
    push filas
    push fmt_input
    call _scanf
    add  esp, 8

    mov  ecx, 1             ; fila actual = 1

.bucle_filas:
    mov  eax, [filas]
    cmp  ecx, eax
    jg   .fin

    ; Calcular espacios = filas - fila_actual
    mov  esi, eax
    sub  esi, ecx

.loop_espacios:
    cmp  esi, 0
    je   .prep_asteriscos
    push ecx
    push esi
    push fmt_espacio
    call _printf
    add  esp, 4
    pop  esi
    pop  ecx
    dec  esi
    jmp  .loop_espacios

.prep_asteriscos:
    ; Calcular asteriscos = 2*fila - 1
    mov  esi, ecx
    imul esi, 2
    dec  esi

.loop_asteriscos:
    cmp  esi, 0
    je   .salto_linea
    push ecx
    push esi
    push fmt_ast
    call _printf
    add  esp, 4
    pop  esi
    pop  ecx
    dec  esi
    jmp  .loop_asteriscos

.salto_linea:
    push ecx
    push fmt_newline
    call _printf
    add  esp, 4
    pop  ecx

    inc  ecx
    jmp  .bucle_filas

.fin:
    push pause_cmd
    call _system
    add  esp, 4

    xor  eax, eax
    pop  ebp
    ret
