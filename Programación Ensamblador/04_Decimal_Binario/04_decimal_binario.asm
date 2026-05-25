; ============================================
; Programa 4: Conversor Decimal a Binario
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 04_decimal_binario.asm -o 04_decimal_binario.obj
; Enlazar:  gcc -m32 04_decimal_binario.obj -o 04_decimal_binario.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _getchar

section .data
    msg_input db "Ingresa un numero entero positivo: ", 0
    fmt_int   db "%d", 0
    msg_res   db "Binario: ", 0
    fmt_char  db "%c", 0
    fmt_nl    db "", 10, 0

section .bss
    numero  resd 1
    buf     resb 33     ; buffer para bits (hasta 32 bits)

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

    ; Construir binario de atras hacia adelante
    lea  edi, [buf + 32]
    mov  byte [edi], 0
    dec  edi

.convertir:
    xor  edx, edx
    mov  ebx, 2
    div  ebx            ; eax = cociente, edx = residuo
    add  dl, '0'
    mov  [edi], dl
    dec  edi
    test eax, eax
    jnz  .convertir

    inc  edi            ; apuntar al primer digito

    push msg_res
    call _printf
    add  esp, 4

    ; Imprimir cada caracter del binario
    mov  esi, edi

.impr_bin:
    movzx eax, byte [esi]
    cmp  al, 0
    je   .fin_impr
    push esi
    push eax
    push fmt_char
    call _printf
    add  esp, 8
    pop  esi
    inc  esi
    jmp  .impr_bin

.fin_impr:
    push fmt_nl
    call _printf
    add  esp, 4

    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
