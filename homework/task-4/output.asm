; file.asm - использование файлов в NASM
extern printf
extern fprintf

extern CircleS
extern RectangleS
extern TriangleS


extern RECTANGLE
extern TRIANGLE
extern CIRCLE

extern  red
extern  orange
extern  yellow
extern  green
extern  light_blue
extern  blue
extern  purple
extern  redstr
extern  orangestr
extern  yellowstr
extern  greenstr
extern  light_bluestr
extern  bluestr
extern  purplestr



global OutRectangle
OutRectangle:
section .data
    .outfmt1 db "It is Rectangle: x1 = %d, y1 = %d, x2 = %d, ",0 
    .outfmt2 db "y2 = %d. S = %f. ",0 
    .outfmtcolor db "Color = %s",10,0
section .bss
    .prect  resq  1
    .FILE   resq  1       ; временное хранение указателя на файл
    .s      resq  1       ; вычисленная площадь прямоугольника
section .text
push rbp
mov rbp, rsp

    ; Сохранени принятых аргументов
    mov     [.prect], rdi          ; сохраняется адрес прямоугольника
    mov     [.FILE], rsi          ; сохраняется указатель на файл

    ; Вычисление площади прямоугольника (адрес уже в rdi)
    call    RectangleS
    movsd   [.s], xmm0          ; сохранение (может лишнее) площади


    ; Вывод информации о прямоугольнике в файл
    mov     rdi, [.FILE]
    mov     rsi, .outfmt1        ; Формат - 2-й аргумент
    mov     rax, [.prect]       ; адрес прямоугольника
    mov     edx, [rax]          ; color
    mov     ecx, [rax+4]        ; x1
    mov     r8,  [rax+8]        ; y1
    mov     rax, 0
    call    fprintf
    
    
    mov     rdi, [.FILE]
    mov     rsi, .outfmt2        ; Формат - 2-й аргумент
    mov     rax, [.prect]       ; адрес прямоугольника
    mov     edx, [rax+12]          ; color
    movsd   xmm0, [.s]
    mov     rax, 1              ; есть числа с плавающей точкой
    call    fprintf

    mov rdi, [.FILE]
    mov rsi, .outfmtcolor
    mov rax, [.prect]
    mov edx, [rax+16]
    cmp edx, [red]
    je rRed
    cmp edx, [orange]
    je rOrange
    cmp edx, [yellow]
    je rYellow
    cmp edx, [green]
    je rGreen
    cmp edx, [light_blue]
    je rLight_blue
    cmp edx, [blue]
    je rBlue
    cmp edx, [purple]
    je rPurple
    jmp endR

    
    rRed:
    mov edx, redstr
    mov rax, 0
    call fprintf
    jmp endR
    rOrange:
    mov edx, orangestr
    mov rax, 0
    call fprintf
    jmp endR
    rYellow:
    mov edx, yellowstr
    mov rax, 0
    call fprintf
    jmp endR
    rGreen:
    mov edx, greenstr
    mov rax, 0
    call fprintf
    jmp endR
    rLight_blue:
    mov edx, light_bluestr
    mov rax, 0
    call fprintf
    jmp endR
    rBlue:
    mov edx, bluestr
    mov rax, 0
    call fprintf
    jmp endR
    rPurple:
    mov edx, purplestr
    mov rax, 0
    call fprintf
    jmp endR
    
endR:  
leave
ret



global OutTriangle
OutTriangle:
section .data
    .outfmt1 db "It is Triangle: x1 = %d, y1 = %d, x2 = %d, ",0   ;color = %s
    .outfmt2 db "y2 = %d, x3 = %d, y3 = %d. S = %f. ",0
    .outfmtcolor db "Color = %s",10,0
section .bss
    .ptrian resq  1
    .FILE   resq  1       ; временное хранение указателя на файл
    .s      resq  1       ; вычисленная площадь треугольника
section .text
push rbp
mov rbp, rsp

    ; Сохранени принятых аргументов
    mov     [.ptrian], rdi          ; сохраняется адрес треугольника
    mov     [.FILE], rsi          ; сохраняется указатель на файл

    ; Вычисление площади треугольника (адрес уже в rdi)
   call    TriangleS
   movsd   [.s], xmm0          ; сохранение (может лишнее) площади


    ; Вывод информации о треугольнике в файл
    mov     rdi, [.FILE]
    mov     rsi, .outfmt1        ; Формат - 2-й аргумент
    mov     rax, [.ptrian]       ; адрес треугольника
    mov     edx, [rax]          ; color
    mov     ecx, [rax+4]        ; x1
    mov     r8,  [rax+8]        ; y1
    mov     rax, 0             ; есть числа с плавающей точкой
    call    fprintf
    
    
    mov     rdi, [.FILE]
    mov     rsi, .outfmt2        ; Формат - 2-й аргумент
    mov     rax, [.ptrian]       ; адрес треугольника
    mov     edx, [rax+12]          ; color
    mov     ecx, [rax+16]        ; x1
    mov     r8,  [rax+20]        ; y1
    movsd   xmm0, [.s]
    mov     rax, 1             ; есть числа с плавающей точкой
    call    fprintf

    mov rdi, [.FILE]
    mov rsi, .outfmtcolor
    mov rax, [.ptrian]
    mov edx, [rax+24]
    cmp edx, [red]
    je tRed
    cmp edx, [orange]
    je tOrange
    cmp edx, [yellow]
    je tYellow
    cmp edx, [green]
    je tGreen
    cmp edx, [light_blue]
    je tLight_blue
    cmp edx, [blue]
    je tBlue
    cmp edx, [purple]
    je tPurple
    jmp endT

    
    tRed:
    mov edx, redstr
    mov rax, 0
    call fprintf
    jmp endT
    tOrange:
    mov edx, orangestr
    mov rax, 0
    call fprintf
    jmp endT
    tYellow:
    mov edx, yellowstr
    mov rax, 0
    call fprintf
    jmp endT
    tGreen:
    mov edx, greenstr
    mov rax, 0
    call fprintf
    jmp endT
    tLight_blue:
    mov edx, light_bluestr
    mov rax, 0
    call fprintf
    jmp endT
    tBlue:
    mov edx, bluestr
    mov rax, 0
    call fprintf
    jmp endT
    tPurple:
    mov edx, purplestr
    mov rax, 0
    call fprintf
    jmp endT
    
endT:  
leave
ret


global OutCircle
OutCircle:
section .data
    .outfmt db "It is Circle: x = %d, y = %d, R = %d. S = %f. ",0 
    .outfmtcolor db "Color = %s",10,0
section .bss
    .pcirc  resq  1
    .FILE   resq  1       ; временное хранение указателя на файл
    .s      resq  1       ; вычисленная площадь круга
section .text
push rbp
mov rbp, rsp
 
    ; Сохранени принятых аргументов
    mov     [.pcirc], rdi          ; сохраняется адрес круга
    mov     [.FILE], rsi          ; сохраняется указатель на файл

    ; Вычисление площади круга (адрес уже в rdi)
    call    CircleS
    movsd   [.s], xmm0          ; сохранение (может лишнее) площади
    
    ; Вывод информации о круге в файл
    mov     rdi, [.FILE]
    mov     rsi, .outfmt        ; Формат - 2-й аргумент
    mov     rax, [.pcirc]       ; адрес круга
    mov     edx, [rax]          ; color
    mov     ecx, [rax+4]        ; x
    mov     r8,  [rax+8]        ; y
    movsd   xmm0, [.s]
    mov     rax, 1              ; есть числа с плавающей точкой
    call    fprintf
    
    
    
    mov rdi, [.FILE]
    mov rsi, .outfmtcolor
    mov rax, [.pcirc]
    mov edx, [rax+12]
    cmp edx, [red]
    je cRed
    cmp edx, [orange]
    je cOrange
    cmp edx, [yellow]
    je cYellow
    cmp edx, [green]
    je cGreen
    cmp edx, [light_blue]
    je cLight_blue
    cmp edx, [blue]
    je cBlue
    cmp edx, [purple]
    je cPurple
    jmp endC

    
    cRed:
    mov edx, redstr
    mov rax, 0
    call fprintf
    jmp endC
    cOrange:
    mov edx, orangestr
    mov rax, 0
    call fprintf
    jmp endC
    cYellow:
    mov edx, yellowstr
    mov rax, 0
    call fprintf
    jmp endC
    cGreen:
    mov edx, greenstr
    mov rax, 0
    call fprintf
    jmp endC
    cLight_blue:
    mov edx, light_bluestr
    mov rax, 0
    call fprintf
    jmp endC
    cBlue:
    mov edx, bluestr
    mov rax, 0
    call fprintf
    jmp endC
    cPurple:
    mov edx, purplestr
    mov rax, 0
    call fprintf
    jmp endC
    
endC:  
leave
ret



global OutShape
OutShape:
section .data
    .erShape     db "Incorrect figure!",10,0
    
section .text
push rbp
mov rbp, rsp
    ; В rdi адрес фигуры
    mov eax, [rdi]
    cmp eax, [RECTANGLE]
    je rectOut
    cmp eax, [TRIANGLE]
    je trianOut
    cmp eax, [CIRCLE]
    je circOut
    mov rdi, .erShape
    mov rax, 0
    call fprintf
    jmp     return
rectOut:
    ; Вывод прямоугольника
    add     rdi, 4
    call    OutRectangle
    jmp     return
trianOut:
    ; Вывод треугольника
    add     rdi, 4
    call    OutTriangle
    jmp     return
circOut:
    ; Вывод круга
    add     rdi, 4
    call    OutCircle
    jmp     return
return:
leave
ret













global OutContainer
OutContainer:
section .data
    numFmt  db  "%d: ",0
section .bss
    .pcont  resq    1   ; адрес контейнера
    .len    resd    1   ; адрес для сохранения числа введенных элементов
    .FILE   resq    1   ; указатель на файл
section .text
push rbp
mov rbp, rsp

    mov [.pcont], rdi   ; сохраняется указатель на контейнер
    mov [.len],   esi     ; сохраняется число элементов
    mov [.FILE],  rdx    ; сохраняется указатель на файл

    ; В rdi адрес начала контейнера
    mov rbx, rsi            ; число фигур
    xor ecx, ecx            ; счетчик фигур = 0
    mov rsi, rdx            ; перенос указателя на файл
.loop:
    cmp ecx, ebx            ; проверка на окончание цикла
    jge .return             ; Перебрали все фигуры

    push rbx
    push rcx

    ; Вывод номера фигуры
    mov     rdi, [.FILE]    ; текущий указатель на файл
    mov     rsi, numFmt     ; формат для вывода фигуры
    mov     edx, ecx        ; индекс текущей фигуры
    xor     rax, rax,       ; только целочисленные регистры
    call fprintf

    ; Вывод текущей фигуры
    mov     rdi, [.pcont]
    mov     rsi, [.FILE]
    call OutShape     ; Получение периметра первой фигуры

    pop rcx
    pop rbx
    inc ecx                 ; индекс следующей фигуры

    mov     rax, [.pcont]
    add     rax, 32         ; адрес следующей фигуры
    mov     [.pcont], rax
    jmp .loop
.return:
leave
ret

