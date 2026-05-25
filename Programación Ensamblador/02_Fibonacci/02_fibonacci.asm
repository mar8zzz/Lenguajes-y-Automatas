; ============================================
; Programa 2: Generador de Secuencia Fibonacci (CORREGIDO)
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 02_fibonacci.asm -o 02_fibonacci.obj
; Enlazar:  gcc -m32 02_fibonacci.obj -o 02_fibonacci.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _system

section .data
    msg_input db "Cuantos terminos de Fibonacci? ", 0
    fmt_int   db "%d", 0
    fmt_num   db "%d", 0
    fmt_sep   db ", ", 0
    fmt_nl    db 10, 0
    pause_cmd db "pause", 0

section .bss
    n resd 1

section .text
_main:
    push ebp
    mov  ebp, esp

    ; Pedir cantidad de terminos
    push msg_input
    call _printf
    add  esp, 4

    ; Leer N
    push n
    push fmt_int
    call _scanf
    add  esp, 8

    mov  ecx, [n]       ; total de terminos
    mov  eax, 0         ; termino a (actual)
    mov  ebx, 1         ; termino b (siguiente)
    mov  edi, 0         ; indice actual

.loop_fib:
    cmp  edi, ecx
    jge  .fin_fib

    ; Guardar registros y imprimir termino actual
    push eax
    push ebx
    push ecx
    push edi

    push eax            ; valor a imprimir
    push fmt_num
    call _printf
    add  esp, 8

    pop  edi
    pop  ecx
    pop  ebx
    pop  eax

    ; Imprimir separador si no es el ultimo
    inc  edi
    cmp  edi, ecx
    je   .skip_sep

    push eax
    push ebx
    push ecx
    push edi
    push fmt_sep
    call _printf
    add  esp, 4
    pop  edi
    pop  ecx
    pop  ebx
    pop  eax

.skip_sep:
    ; Calcular siguiente: temp = a+b, a = b, b = temp
    mov  edx, eax
    add  edx, ebx
    mov  eax, ebx
    mov  ebx, edx
    jmp  .loop_fib

.fin_fib:
    ; Salto de linea
    push fmt_nl
    call _printf
    add  esp, 4

    ; Pausar para que no se cierre la ventana
    push pause_cmd
    call _system
    add  esp, 4

    xor  eax, eax
    pop  ebp
    ret
