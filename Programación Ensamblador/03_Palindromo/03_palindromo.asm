; ============================================
; Programa 3: Validador de Palindromos (CORREGIDO v2)
; Acepta frases con espacios como "anita lava la tina"
; Ignora espacios y mayusculas/minusculas
; Ensamblador: NASM | Sistema: Windows x86
; Compilar: nasm -f win32 03_palindromo.asm -o 03_palindromo.obj
; Enlazar:  gcc -m32 03_palindromo.obj -o 03_palindromo.exe
; ============================================

global _main
extern _printf
extern _gets
extern _strlen
extern _tolower
extern _system

section .data
    msg_input db "Ingresa una cadena: ", 0
    msg_si    db "Es palindromo", 10, 0
    msg_no    db "No es palindromo", 10, 0
    pause_cmd db "pause", 0

section .bss
    cadena  resb 128
    limpia  resb 128

section .text
_main:
    push ebp
    mov  ebp, esp

    ; Mostrar mensaje
    push msg_input
    call _printf
    add  esp, 4

    ; Leer linea completa con gets (acepta espacios, no necesita stdin)
    push cadena
    call _gets
    add  esp, 4

    ; ---- Limpiar: quitar espacios y poner en minusculas ----
    mov  esi, cadena
    mov  edi, limpia

.loop_limpiar:
    movzx eax, byte [esi]
    cmp  al, 0
    je   .fin_limpiar

    ; Saltar espacios
    cmp  al, ' '
    je   .sig_char

    ; Convertir a minuscula
    push esi
    push edi
    push eax
    call _tolower
    add  esp, 4
    pop  edi
    pop  esi

    mov  [edi], al
    inc  edi

.sig_char:
    inc  esi
    jmp  .loop_limpiar

.fin_limpiar:
    mov  byte [edi], 0

    ; ---- Comparar palindromo ----
    push limpia
    call _strlen
    add  esp, 4

    cmp  eax, 0
    je   .no_palindromo

    mov  esi, limpia
    lea  edi, [limpia + eax - 1]

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
    push pause_cmd
    call _system
    add  esp, 4

    xor  eax, eax
    pop  ebp
    ret
