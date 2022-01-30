//
// Created by Rusta on 30.01.2022.
//

#ifndef ACS_HW1_SHAPE_H
#define ACS_HW1_SHAPE_H

//------------------------------------------------------------------------------
// shape.h - содержит описание обобщающей геометрической фигуры,
//------------------------------------------------------------------------------

#include "rectangle.h"
#include "triangle.h"
#include "circle.h"

//------------------------------------------------------------------------------
// структура, обобщающая все имеющиеся фигуры
struct shape {
    // значения ключей для каждой из фигур
    enum key {RECTANGLE = 1, TRIANGLE, CIRCLE};
    key k; // ключ
    union { // используем простейшую реализацию
        rectangle r;
        triangle t;
        circle c;
    };
};

// Ввод обобщенной фигуры
shape *In(std::ifstream &ifdt);

// Случайный ввод обобщенной фигуры
shape *InRnd();

// Вывод обобщенной фигуры
void Out(shape &s, std::ofstream &ofst);

// Вычисление площади обобщенной фигуры
double Area(shape &s);

#endif //ACS_HW1_SHAPE_H
