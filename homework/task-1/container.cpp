//------------------------------------------------------------------------------
// container_Constr.cpp - содержит функции обработки контейнера
//------------------------------------------------------------------------------

#include "container.h"

//------------------------------------------------------------------------------
// Инициализация контейнера
void Init(container &c) {
    c.len = 0;
}

//------------------------------------------------------------------------------
// Очистка контейнера от элементов (освобождение памяти)
void Clear(container &c) {
    for (int i = 0; i < c.len; ++i) {
        delete c.cont[i];
    }
    c.len = 0;
}

//------------------------------------------------------------------------------
// Ввод содержимого контейнера из указанного потока
void In(container &c, std::ifstream &ifst) {
    while (!ifst.eof()) {
        if ((c.cont[c.len] = In(ifst)) != nullptr) {
            c.len++;
        }
    }
}

//------------------------------------------------------------------------------
// Случайный ввод содержимого контейнера
void InRnd(container &c, int size) {
    while (c.len < size) {
        if ((c.cont[c.len] = InRnd()) != nullptr) {
            c.len++;
        }
    }
}

//------------------------------------------------------------------------------
// Вывод содержимого контейнера в указанный поток
void Out(container &c, std::ofstream &ofst) {
    ofst << "Container contains " << c.len << " elements." << '\n';
    for (int i = 0; i < c.len; ++i) {
        ofst << i + 1 << ": ";
        Out(*(c.cont[i]), ofst);
    }
}

//------------------------------------------------------------------------------
// Сортировка пузырьком
void BubbleSort(container &c) {
    bool swapped;
    for (int i = 0; i < c.len; ++i)
    {
        swapped = false;
        for (int j = 0; j < c.len-i-1; ++j)
        {
            if (Area(*c.cont[j]) > Area(*c.cont[j + 1]))
            {
                std::swap(c.cont[j], c.cont[j+1]);
                swapped = true;
            }
        }

        // IF no two elements were swapped by inner loop, then break
        if (!swapped)
            break;
    }
}
