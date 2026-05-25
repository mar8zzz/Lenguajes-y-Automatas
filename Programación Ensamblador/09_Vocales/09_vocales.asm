; ============================================
; Programa 9: Contador de Vocales, Consonantes y Digitos
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 09_vocales.asm -o 09_vocales.obj
; Enlazar:  gcc -m32 09_vocales.obj -o 09_vocales.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _getchar

section .data
    msg_input db "Ingresa una cadena: ", 0
    fmt_str   db "%127s", 0
    msg_voc   db "Vocales:     %d", 10, 0
    msg_con   db "Consonantes: %d", 10, 0
    msg_dig   db "Digitos:     %d", 10, 0
    vocales   db "aeiouAEIOU", 0

section .bss
    cadena    resb 128
    cnt_voc   resd 1
    cnt_con   resd 1
    cnt_dig   resd 1

section .text
_main:
    push ebp
    mov  ebp, esp

    ; Inicializar contadores
    mov dword [cnt_voc], 0
    mov dword [cnt_con], 0
    mov dword [cnt_dig], 0

    push msg_input
    call _printf
    add  esp, 4

    push cadena
    push fmt_str
    call _scanf
    add  esp, 8

    mov  esi, cadena

.loop_chars:
    movzx eax, byte [esi]
    cmp  al, 0
    je   .imprimir

    ; Digito?
    cmp  al, '0'
    jl   .check_letra
    cmp  al, '9'
    jg   .check_letra
    inc  dword [cnt_dig]
    jmp  .siguiente

.check_letra:
    ; Mayuscula?
    cmp  al, 'A'
    jl   .siguiente
    cmp  al, 'z'
    jg   .siguiente
    cmp  al, 'Z'
    jle  .es_letra
    cmp  al, 'a'
    jge  .es_letra
    jmp  .siguiente

.es_letra:
    ; Buscar en vocales
    mov  edi, vocales
.buscar_vocal:
    movzx ebx, byte [edi]
    cmp  bl, 0
    je   .es_consonante
    cmp  al, bl
    je   .es_vocal
    inc  edi
    jmp  .buscar_vocal

.es_vocal:
    inc  dword [cnt_voc]
    jmp  .siguiente

.es_consonante:
    inc  dword [cnt_con]

.siguiente:
    inc  esi
    jmp  .loop_chars

.imprimir:
    push dword [cnt_voc]
    push msg_voc
    call _printf
    add  esp, 8

    push dword [cnt_con]
    push msg_con
    call _printf
    add  esp, 8

    push dword [cnt_dig]
    push msg_dig
    call _printf
    add  esp, 8

    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
