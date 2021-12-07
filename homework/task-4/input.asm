; file.asm - использование файлов в NASM
extern printf
extern fscanf


extern RECTANGLE
extern TRIANGLE
extern CIRCLE


global InRectangle
InRectangle:
section .data
    .infmt1 db "%d%d%d%d",0
    .infmt2 db "%d",0
section .bss
    .FILE   resq    1   
    .rect  resq     1 
section .text
push rbp
mov rbp, rsp
    
    mov     [.rect], rdi          
    mov     [.FILE], rsi         
 
    mov     rdi, [.FILE]
    mov     rsi, .infmt1         
    mov     rdx, [.rect]       
    mov     rcx, [.rect]
    add     rcx, 4              
    mov     r8, [.rect]
    add     r8, 8              
    mov     r9, [.rect]
    add     r9, 12 
    mov     rax, 0              
    call    fscanf
    
    mov     rdi, [.FILE]
    mov     rsi, .infmt2         
    mov     rdx, [.rect]
    add     rdx, 16       
    mov     rax, 0              
    call    fscanf

leave
ret


global InTriangle
InTriangle:
section .data
    .infmt1 db "%d%d%d%d",0
    .infmt2 db "%d%d%d",0
section .bss
    .FILE   resq    1   ; временное хранение указателя на файл
    .trian  resq    1   ; адрес треугольника
section .text
push rbp
mov rbp, rsp

    ; Сохранение принятых аргументов
    mov     [.trian], rdi          ; сохраняется адрес треугольника
    mov     [.FILE], rsi          ; сохраняется указатель на файл

    ; Ввод треугольника из файла
    mov     rdi, [.FILE]
    mov     rsi, .infmt1         ; Формат - 1-й аргумент
    mov     rdx, [.trian]       ; &a
    mov     rcx, [.trian]
    add     rcx, 4              ; &b = &a + 4
    mov     r8, [.trian]
    add     r8, 8               ; &c = &x + 8
    mov     r9, [.trian]
    add     r9, 12
    mov     rax, 0              ; нет чисел с плавающей точкой
    call    fscanf

    mov     rdi, [.FILE]
    mov     rsi, .infmt2        ; Формат - 1-й аргумент
    mov     rdx, [.trian]       ; &a
    add     rdx, 16
    mov     rcx, [.trian]
    add     rcx, 20              ; &b = &a + 4
    mov     r8, [.trian]
    add     r8, 24               ; &c = &x + 8
    mov     rax, 0              ; нет чисел с плавающей точкой
    call    fscanf

leave
ret

global InCircle
InCircle:
section .data
    .infmt db "%d%d%d%d",0
section .bss
    .FILE   resq    1   ; временное хранение указателя на файл
    .circ  resq    1   ; адрес треугольника
section .text
push rbp
mov rbp, rsp

    ; Сохранение принятых аргументов
    mov     [.circ], rdi          ; сохраняется адрес треугольника
    mov     [.FILE], rsi          ; сохраняется указатель на файл

    ; Ввод треугольника из файла
    mov     rdi, [.FILE]
    mov     rsi, .infmt         ; Формат - 1-й аргумент
    mov     rdx, [.circ]       ; &a
    mov     rcx, [.circ]
    add     rcx, 4              ; &b = &a + 4
    mov     r8, [.circ]
    add     r8, 8               ; &c = &x + 8
    mov     r9, [.circ]
    add     r9, 12
    mov     rax, 0              ; нет чисел с плавающей точкой
    call    fscanf

leave
ret


global InShape
InShape:
section .data
    .tagFormat   db      "%d",0
    .tagOutFmt   db     "Tag is: %d",10,0
section .bss
    .FILE       resq    1   ; временное хранение указателя на файл
    .pshape     resq    1   ; адрес фигуры
    .shapeTag   resd    1   ; признак фигуры
section .text
push rbp
mov rbp, rsp

    ; Сохранение принятых аргументов
    mov     [.pshape], rdi          ; сохраняется адрес фигуры
    mov     [.FILE], rsi            ; сохраняется указатель на файл

    ; чтение признака фигуры и его обработка
    mov     rdi, [.FILE]
    mov     rsi, .tagFormat
    mov     rdx, [.pshape]      ; адрес начала фигуры (ее признак)
    xor     rax, rax            ; нет чисел с плавающей точкой
    call    fscanf


    mov rcx, [.pshape]          ; загрузка адреса начала фигуры
    mov eax, [rcx]              ; и получение прочитанного признака
    cmp eax, [RECTANGLE]
    je .rectIn
    cmp eax, [TRIANGLE]
    je .trianIn
    cmp eax, [CIRCLE]
    je .circIn
    xor eax, eax    ; Некорректный признак - обнуление кода возврата
    jmp     .return
.rectIn:
    ; Ввод прямоугольника
    mov     rdi, [.pshape]
    add     rdi, 4
    mov     rsi, [.FILE]
    call    InRectangle
    mov     rax, 1  ; Код возврата - true
    jmp     .return
.trianIn:
    ; Ввод треугольника
    mov     rdi, [.pshape]
    add     rdi, 4
    mov     rsi, [.FILE]
    call    InTriangle
    mov     rax, 1  ; Код возврата - true
    jmp     .return
.circIn:
    ; Ввод треугольника
    mov     rdi, [.pshape]
    add     rdi, 4
    mov     rsi, [.FILE]
    call    InCircle
    mov     rax, 1  ; Код возврата - true
    jmp     .return
.return:

leave
ret


global InContainer
InContainer:
section .bss
    .pcont  resq    1   ; адрес контейнера
    .plen   resq    1   ; адрес для сохранения числа введенных элементов
    .FILE   resq    1   ; указатель на файл
section .text
push rbp
mov rbp, rsp

    mov [.pcont], rdi   ; сохраняется указатель на контейнер
    mov [.plen], rsi    ; сохраняется указатель на длину
    mov [.FILE], rdx    ; сохраняется указатель на файл
    ; В rdi адрес начала контейнера
    xor rbx, rbx        ; число фигур = 0
    mov rsi, rdx        ; перенос указателя на файл
.loop:
    ; сохранение рабочих регистров
    push rdi
    push rbx

    mov     rsi, [.FILE]
    mov     rax, 0      ; нет чисел с плавающей точкой
    call    InShape     ; ввод фигуры
    cmp rax, 0          ; проверка успешности ввода
    jle  .return        ; выход, если признак меньше или равен 0

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

