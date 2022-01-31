//------------------------------------------------------------------------------
// container_Constr.cpp - содержит функции обработки контейнера
//------------------------------------------------------------------------------

#include "container.h"
#include <iostream>

//------------------------------------------------------------------------------
// Конструктор контейнера
Container::Container(int s) : len{0}, size{s} {
    storage = new Shape *[s];
}

//------------------------------------------------------------------------------
// Деструктор контейнера
Container::~Container() {
    Clear();
    delete[] storage;
}

//------------------------------------------------------------------------------
// Очистка контейнера от элементов (освобождение памяти)
void Container::Clear() {
    for (int i = 0; i < len; ++i) {
        delete storage[i];
    }
    len = 0;
}

//------------------------------------------------------------------------------
// Вывод содержимого контейнера в указанный поток
void Container::Out(ofstream &ofst) {
    ofst << "Container contains " << len << " elements.\n";
    for (int i = 0; i < len; ++i) {
        ofst << i << ": ";
        storage[i]->Out(ofst);
    }

}

//------------------------------------------------------------------------------
// Ввод содержимого контейнера из указанного потока
void Container::In(ifstream &ifst) {
    while (!ifst.eof()) {
        if ((storage[len] = Shape::StaticIn(ifst)) != 0) {
            len++;
        }
    }
}

//------------------------------------------------------------------------------
// Случайный ввод содержимого контейнера
void Container::InRnd(int s) {
    if (s > size) {
        s = size;
    }
    while (len < s) {
        if ((storage[len] = Shape::StaticInRnd()) != nullptr) {
            len++;
        }
    }
}

//------------------------------------------------------------------------------
// Сортировка пузырьком по площади фигур
void Container::BubbleSort() {
    bool swapped;
    for (int i = 0; i < len - 1; ++i) {
        swapped = false;
        for (int j = 0; j < len - i - 1; ++j) {
            if (storage[j]->Area() > storage[j + 1]->Area()) {
                std::swap(storage[j], storage[j + 1]);
                swapped = true;
            }
        }

        // IF no two elements were swapped by inner loop, then break
        if (!swapped)
            break;
    }
}