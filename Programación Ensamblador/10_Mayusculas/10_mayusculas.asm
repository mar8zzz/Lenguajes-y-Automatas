; ============================================
; Programa 10: Conversor de Mayusculas a Minusculas
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 10_mayusculas.asm -o 10_mayusculas.obj
; Enlazar:  gcc -m32 10_mayusculas.obj -o 10_mayusculas.exe
; ============================================

global _main
extern _printf
extern _getchar

section .data
    cadena   db "HOLA MUNDO EN ENSAMBLADOR", 0
    longitud equ $ - cadena - 1
    msg_orig db "Original:   HOLA MUNDO EN ENSAMBLADOR", 10, 0
    msg_conv db "Convertida: ", 0
    fmt_char db "%c", 0
    fmt_nl   db "", 10, 0

section .bss
    resultado resb 64

section .text
_main:
    push ebp
    mov  ebp, esp

    ; Copiar y convertir cadena
    mov  esi, cadena
    mov  edi, resultado
    mov  ecx, longitud

.loop_conv:
    cmp  ecx, 0
    je   .fin_conv

    movzx eax, byte [esi]

    ; Si es mayuscula (A-Z), sumar 32
    cmp  al, 'A'
    jl   .copiar
    cmp  al, 'Z'
    jg   .copiar
    add  al, 32

.copiar:
    mov  [edi], al
    inc  esi
    inc  edi
    dec  ecx
    jmp  .loop_conv

.fin_conv:
    mov  byte [edi], 0

    ; Imprimir original
    push msg_orig
    call _printf
    add  esp, 4

    ; Imprimir "Convertida: "
    push msg_conv
    call _printf
    add  esp, 4

    ; Imprimir resultado caracter por caracter
    mov  esi, resultado

.impr_res:
    movzx eax, byte [esi]
    cmp  al, 0
    je   .impr_nl
    push esi
    push eax
    push fmt_char
    call _printf
    add  esp, 8
    pop  esi
    inc  esi
    jmp  .impr_res

.impr_nl:
    push fmt_nl
    call _printf
    add  esp, 4

    call _getchar
    xor  eax, eax
    pop  ebp
    ret
