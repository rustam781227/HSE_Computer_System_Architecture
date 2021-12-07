extern CIRCLE
extern RECTANGLE
extern TRIANGLE

global RectangleS
RectangleS:
section .bss
    .s   resd 1
section .text
push rbp
mov rbp, rsp
    ; В rdi адрес прямоугольника
    finit
    mov eax, [rdi+8] ;x2
    sub eax, [rdi]  ;x2-x1
    mov ebx, [rdi+4]  ;y2
    sub ebx, [rdi+12] ;y1-y2
    imul eax, ebx  ; -или мул просто
    mov [.s], eax
    fild dword [.s]
    fabs
    fist dword [.s]
    mov eax, [.s]
    cvtsi2sd  xmm0, eax
   
leave
ret

global TriangleS
TriangleS:
section .data
    .two dd 0.5
section .bss
    .s   resd 1
section .text
push rbp
mov rbp, rsp
    finit
    mov eax, [rdi+8]
    sub eax, [rdi] ;x2-x1
    
    mov r8d, [rdi+20]
    sub r8d, [rdi+4] ; y3-y1
    
    mov r9d, [rdi+16]
    sub r9d, [rdi] ; x3-x1
    
    mov r10d, [rdi+12]
    sub r10d, [rdi+4] ; y2-y1
    
    imul eax, r8d
    imul r9d, r10d

    sub eax, r9d
    mov [.s], eax
    fild dword [.s]
    
    fabs
    fmul dword [.two]
    fist dword [.s]
    mov eax, [.s]
    
    cvtsi2sd xmm0, eax

leave
ret

global CircleS
CircleS:
section .data
    .pi dd 3.14
section .bss
    .s   resb 8
section .text
push rbp
mov rbp, rsp

    finit
    mov eax, [rdi+8]
    mov [.s], eax
    fld dword [.s]
    fimul dword [.s]
    fmul dword [.pi]
    fst dword [.s]
    mov eax, [.s]
    cvtsi2sd xmm0, eax

leave
ret

global ShapeS
ShapeS:
section .text
push rbp
mov rbp, rsp
    ; В rdi адрес фигуры
    mov eax, [rdi]
    cmp eax, [RECTANGLE]
    je rectS
    cmp eax, [TRIANGLE]
    je trianS
    cmp eax, [CIRCLE]
    je circS

rectS:
    ; Вычисление периметра прямоугольника
    add     rdi, 4
    call    RectangleS
    jmp     return
trianS:
    ; Вычисление периметра треугольника
    add     rdi, 4
    call    TriangleS
    jmp     return
circS:
    ; Вычисление периметра прямоугольника
    add     rdi, 4
    call    CircleS
    jmp     return
return:
leave
ret

global SSumContainer
SSumContainer:
section .data
    .sum    dq  0.0
section .text
push rbp
mov rbp, rsp

    ; В rdi адрес начала контейнера
    mov ebx, esi            ; число фигур
    xor ecx, ecx            ; счетчик фигур
    movsd xmm1, [.sum]      ; перенос накопителя суммы в регистр 1
.loop:
    cmp ecx, ebx            ; проверка на окончание цикла
    jge .return             ; Перебрали все фигуры

    mov r10, rdi            ; сохранение начала фигуры
    call ShapeS     ; Получение периметра первой фигуры
    addsd xmm1, xmm0        ; накопление суммы
    inc ecx                 ; индекс следующей фигуры
    add r10, 32             ; адрес следующей фигуры
    mov rdi, r10            ; восстановление для передачи параметра
    jmp .loop
.return:
    movsd xmm0, xmm1
leave
ret
