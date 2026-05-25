; ============================================
; Programa 3: Validador de Palindromos
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 03_palindromo.asm -o 03_palindromo.obj
; Enlazar:  gcc -m32 03_palindromo.obj -o 03_palindromo.exe
; ============================================

global _main
extern _printf
extern _scanf
extern _strlen
extern _getchar

section .data
    msg_input db "Ingresa una cadena: ", 0
    fmt_str   db "%63s", 0
    msg_si    db "Es palindromo", 10, 0
    msg_no    db "No es palindromo", 10, 0

section .bss
    cadena resb 64

section .text
_main:
    push ebp
    mov  ebp, esp

    push msg_input
    call _printf
    add  esp, 4

    push cadena
    push fmt_str
    call _scanf
    add  esp, 8

    ; Obtener longitud
    push cadena
    call _strlen
    add  esp, 4
    ; eax = longitud

    mov  esi, cadena            ; puntero izquierdo
    lea  edi, [cadena + eax - 1]; puntero derecho

.comparar:
    cmp  esi, edi
    jge  .es_palindromo

    mov  al, [esi]
    mov  bl, [edi]
    cmp  al, bl
    jne  .no_palindromo

    inc  esi
    dec  edi
    jmp  .comparar

.es_palindromo:
    push msg_si
    call _printf
    add  esp, 4
    jmp  .fin

.no_palindromo:
    push msg_no
    call _printf
    add  esp, 4

.fin:
    call _getchar
    call _getchar
    xor  eax, eax
    pop  ebp
    ret
