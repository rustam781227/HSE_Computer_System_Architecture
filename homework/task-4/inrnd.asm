extern printf
extern rand

extern RECTANGLE
extern TRIANGLE
extern CIRCLE


global RandomType
RandomType:
section .data
    .i3     dq      3
    .rndNumFmt       db "Random number = %d",10,0
section .text
push rbp
mov rbp, rsp

    xor     rax, rax    ;
    call    rand        ; запуск генератора случайных чисел
    xor     rdx, rdx    ; обнуление перед делением
    idiv    qword[.i3]       ; (/%) -> остаток в rdx
    mov     rax, rdx
    inc     rax         ; должно сформироваться случайное число

leave
ret

global RandomColor
RandomColor:
section .data
    .i7     dq      7
    .rndNumFmt       db "Random number = %d",10,0
section .text
push rbp
mov rbp, rsp

    xor     rax, rax    ;
    call    rand        ; запуск генератора случайных чисел
    xor     rdx, rdx    ; обнуление перед делением
    idiv    qword[.i7]       ; (/%) -> остаток в rdx
    mov     rax, rdx
    inc     rax         ; должно сформироваться случайное число

leave
ret

global Random
Random:
section .data
    .i100     dq      100
    .rndNumFmt       db "Random number = %d",10,0
section .text
push rbp
mov rbp, rsp

    xor     rax, rax    ;
    call    rand        ; запуск генератора случайных чисел
    xor     rdx, rdx    ; обнуление перед делением
    idiv    qword[.i100]       ; (/%) -> остаток в rdx
    mov     rax, rdx
    inc     rax         ; должно сформироваться случайное число

leave
ret

global InRndRectangle
InRndRectangle:
section .bss
    .prect  resq 1   ; адрес прямоугольника
section .text
push rbp
mov rbp, rsp

    ; В rdi адрес прямоугольника
    mov     [.prect], rdi
    ; Генерация сторон прямоугольника
    call    Random
    mov     rbx, [.prect]
    mov     [rbx], eax
    call    Random
    mov     rbx, [.prect]
    mov     [rbx+4], eax
    call    Random
    mov     rbx, [.prect]
    mov     [rbx+8], eax
    call    Random
    mov     rbx, [.prect]
    mov     [rbx+12], eax
    call    RandomColor
    mov     rbx, [.prect]
    mov     [rbx+16], eax

leave
ret


global InRndTriangle
InRndTriangle:
section .bss
    .ptrian  resq 1   ; адрес треугольника
section .text
push rbp
mov rbp, rsp

    ; В rdi адрес треугольника
    mov     [.ptrian], rdi
    ; Генерация сторон треугольника
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx], eax
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx+4], eax
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx+8], eax
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx+12], eax
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx+16], eax
    call    Random
    mov     rbx, [.ptrian]
    mov     [rbx+20], eax
    call    RandomColor
    mov     rbx, [.ptrian]
    mov     [rbx+24], eax

leave
ret


global InRndCircle
InRndCircle:
section .bss
    .pcirc  resq 1   ; адрес круга
section .text
push rbp
mov rbp, rsp

    ; В rdi адрес круга
    mov     [.pcirc], rdi
    ; Генерация сторон круга
    call    Random
    mov     rbx, [.pcirc]
    mov     [rbx], eax
    call    Random
    mov     rbx, [.pcirc]
    mov     [rbx+4], eax
    call    Random
    mov     rbx, [.pcirc]
    mov     [rbx+8], eax
    call    RandomColor
    mov     rbx, [.pcirc]
    mov     [rbx+12], eax

leave
ret

global InRndShape
InRndShape:
section .data
    .rndNumFmt       db "Random number = %d",10,0
section .bss
    .pshape     resq    1   ; адрес фигуры
    .key        resd    1   ; ключ
section .text
push rbp
mov rbp, rsp
  ; В rdi адрес фигуры
    mov [.pshape], rdi

    ; Формирование признака фигуры
    xor     rax, rax    ;
    call    RandomType        ; запуск генератора случайных чисел
    mov     rdi, [.pshape]
    mov     [rdi], eax      ; запись ключа в фигуру
    cmp eax, [RECTANGLE]
    je .rectInrnd
    cmp eax, [TRIANGLE]
    je .trianInRnd
    cmp eax, [CIRCLE]
    je .circInRnd
    xor eax, eax        ; код возврата = 0
    jmp     .return
.rectInrnd:
    ; Генерация прямоугольника
    add     rdi, 4
    call    InRndRectangle
    mov     eax, 1      ;код возврата = 1
    jmp     .return
.trianInRnd:
    ; Генерация треугольника
    add     rdi, 4
    call    InRndTriangle
    mov     eax, 1      ;код возврата = 1
    jmp     .return
.circInRnd:
    ; Генерация круга
    add     rdi, 4
    call    InRndCircle
    mov     eax, 1      ;код возврата = 1
    jmp     .return
.return:
leave
ret

global InRndContainer
InRndContainer:
section .bss
    .pcont  resq    1   ; адрес контейнера
    .plen   resq    1   ; адрес для сохранения числа введенных элементов
    .psize  resd    1   ; число порождаемых элементов
section .text
push rbp
mov rbp, rsp

    mov [.pcont], rdi   ; сохраняется указатель на контейнер
    mov [.plen], rsi    ; сохраняется указатель на длину
    mov [.psize], edx    ; сохраняется число порождаемых элементов
    ; В rdi адрес начала контейнера
    xor ebx, ebx        ; число фигур = 0
.loop:
    cmp ebx, edx
    jge     .return
    ; сохранение рабочих регистров
    push rdi
    push rbx
    push rdx

    call    InRndShape     ; ввод фигуры
    cmp rax, 0          ; проверка успешности ввода
    jle  .return        ; выход, если признак меньше или равен 0

    pop rdx
    pop rbx
    inc rbx

    pop rdi
    add rdi, 32             ; адрес следующей фигуры

    jmp .loop
.return:
    mov rax, [.plen]    ; перенос указателя на длину
    mov [rax], ebx      ; занесение длины
    
leave
ret
