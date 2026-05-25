; ============================================
; Programa 6: Busqueda del Numero Mayor en Arreglo
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 06_numero_mayor.asm -o 06_numero_mayor.obj
; Enlazar:  gcc -m32 06_numero_mayor.obj -o 06_numero_mayor.exe
; ============================================

global _main
extern _printf
extern _getchar

section .data
    arreglo  dd 45, 12, 78, 34, 90, 23, 67, 5, 88, 41
    longitud equ 10
    msg_arr  db "Arreglo: 45, 12, 78, 34, 90, 23, 67, 5, 88, 41", 10, 0
    msg_res  db "Numero mayor: %d", 10, 0

section .text
_main:
    push ebp
    mov  ebp, esp

    push msg_arr
    call _printf
    add  esp, 4

    ; Inicializar maximo con primer elemento
    mov  esi, arreglo
    mov  eax, [esi]
    mov  ecx, longitud - 1
    add  esi, 4

.bucle:
    cmp  ecx, 0
    je   .imprimir

    mov  edx, [esi]
    cmp  edx, eax
    jle  .siguiente
    mov  eax, edx

.siguiente:
    add  esi, 4
    dec  ecx
    jmp  .bucle

.imprimir:
    push eax
    push msg_res
    call _printf
    add  esp, 8

    call _getchar
    xor  eax, eax
    pop  ebp
    ret
