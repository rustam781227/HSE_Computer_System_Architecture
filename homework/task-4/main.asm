global  RECTANGLE
global  TRIANGLE
global  CIRCLE

global  red
global  orange
global  yellow
global  green
global  light_blue
global  blue
global  purple
global  redstr
global  orangestr
global  yellowstr
global  greenstr
global  light_bluestr
global  bluestr
global  purplestr

%include "macros.mac"

section .data
    red            dd     1
    orange         dd     2
    yellow         dd     3
    green          dd     4
    light_blue     dd     5
    blue           dd     6
    purple         dd     7
    redstr         db     "red",0
    orangestr      db     "orange",0
    yellowstr      db     "yellow",0
    greenstr       db     "green",0
    light_bluestr  db     "light blue",0
    bluestr        db     "blue",0
    purplestr      db     "purple",0 

    RECTANGLE      dd     1 
    TRIANGLE       dd     2
    CIRCLE         dd     3
    oneDouble      dq     1.0
    erMsg1         db     "Incorrect number of arguments = %d: ",10,0
    rndGen         db     "-n",0
    fileGen        db     "-f",0
    errMessage1    db     "incorrect command line!", 10,"  Waited:",10
                   db     "     command -f infile outfile",10,"  Or:",10
                   db     "     command -n number outfile",10,0
    errMessage2    db     "incorrect qualifier value!", 10,"  Waited:",10
                   db     "     command -f infile outfile",10,"  Or:",10
                   db     "     command -n number outfile",10,0
    len            dd     0       ; Количество элементов в массиве
section .bss
    argc           resd   1
    num            resd   1
    sum            resq   1
    start          resq   1       ; начало отсчета времени
    delta          resq   1       ; интервал отсчета времени
    startTime      resq   2       ; начало отсчета времени
    endTime        resq   2       ; конец отсчета времени
    deltaTime      resq   2       ; интервал отсчета времени
    ifst           resq   1       ; указатель на файл, открываемый файл для чтения фигур
    ofst1          resq   1       ; указатель на файл, открываемый файл для записи контейнера
    ofst2          resq   1       ; указатель на файл, открываемый файл для записи периметра
    cont           resb   320000  ; Массив используемый для хранения данных
section .text 
    global main
main:
push rbp
mov rbp,rsp
    
    mov dword [argc], edi ;rdi contains number of arguments
    mov r12, rdi ;rdi contains number of arguments
    mov r13, rsi ;rsi contains the address to the array of arguments

    cmp r12, 4      ; проверка количества аргументов
    je .next1
    PrintStrBuf errMessage1, [stdout]
    jmp .return
    
.next1:
    PrintStrLn "Start", [stdout]
    ; Проверка второго аргумента
    mov rdi, rndGen     ; признак для сравнения
    mov rsi, [r13+8]    ; второй аргумент командной строки
    mov rcx, 3          ; сравнение, включая нуль (обе строки завершились)
    cld                 ; обнуление флага направления (инкремент)
    repe cmpsb
    je .next2
    mov rdi, fileGen
    mov rsi, [r13+8]    ; второй аргумент командной строки
    mov rcx, 3          ; сравнение, включая нуль (обе строки завершились)
    cld                 ; обнуление флага направления (инкремент)
    repe cmpsb
    je .next3
    PrintStrBuf errMessage2, [stdout]
    jmp .return   
    
.next2:
    ; Генерация случайных фигур
    mov rdi, [r13+16]
    call atoi
    mov [num], eax
    mov eax, [num]
    cmp eax, 1
    jl .fall1
    cmp eax, 10000
    jg .fall1
    ; Начальная установка генератора случайных чисел
    xor     rdi, rdi
    xor     rax, rax
    call    time
    mov     rdi, rax
    xor     rax, rax
    call    srand
    ; Заполнение контейнера случайными фигурами
    mov     rdi, cont   ; передача адреса контейнера
    mov     rsi, len    ; передача адреса для длины
    mov     edx, [num]  ; передача количества порождаемых фигур
    call    InRndContainer
    jmp .task2

.next3:
    ; Получение фигур из файла
    FileOpen [r13+16], "r", ifst
    ; Заполнение контейнера фигурами из файла
    mov     rdi, cont           ; адрес контейнера
    mov     rsi, len            ; адрес для установки числа элементов
    mov     rdx, [ifst]         ; указатель на файл
    xor     rax, rax
    call    InContainer         ; ввод данных в контейнер
    FileClose [ifst]

.task2:
    ; Вывод содержимого контейнера
    PrintStrLn "Filled container:", [stdout]
    PrintContainer cont, [len], [stdout]
    FileOpen [r13+24], "w", ofst1
    PrintStrLn "Filled container:", [ofst1]
    PrintContainer cont, [len], [ofst1]
    FileClose [ofst1]
    ; Вычисление времени старта
    mov rax, 228   ; 228 is system call for sys_clock_gettime
    xor edi, edi   ; 0 for system clock (preferred over "mov rdi, 0")
    lea rsi, [startTime]
    syscall        ; [time] contains number of seconds
                   ; [time + 8] contains number of nanoseconds
                              
    
    ; Вычисление времени завершения
    mov rax, 228   ; 228 is system call for sys_clock_gettime
    xor edi, edi   ; 0 for system clock (preferred over "mov rdi, 0")
    lea rsi, [endTime]
    syscall        ; [time] contains number of seconds
                   ; [time + 8] contains number of nanoseconds

    ; Получение времени работы
    mov rax, [endTime]
    sub rax, [startTime]
    mov rbx, [endTime+8]
    mov rcx, [startTime+8]
    cmp rbx, rcx
    jge .subNanoOnly
    ; иначе занимаем секунду
    dec rax
    add rbx, 1000000000
    
.subNanoOnly:
    sub rbx, [startTime+8]
    mov [deltaTime], rax
    mov [deltaTime+8], rbx

    PrintStr "Calculaton time = ", [stdout]
    PrintLLUns [deltaTime], [stdout]
    PrintStr " sec, ", [stdout]
    PrintLLUns [deltaTime+8], [stdout]
    PrintStr " nsec", [stdout]
    PrintStr 10, [stdout]

    PrintStrLn "Stop", [stdout]
    jmp .return
    
.fall1:
    PrintStr "incorrect numer of figures = ", [stdout]
    PrintInt [num], [stdout]
    PrintStrLn ". Set 0 < number <= 10000", [stdout]
    
.return:
    leave
    ret
