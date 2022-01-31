//
// Created by Rusta on 31.01.2022.
//

#ifndef ACS_HW2_SHAPE_H
#define ACS_HW2_SHAPE_H

//------------------------------------------------------------------------------
// shape.h - содержит описание обобщающей геометрической фигуры,
//------------------------------------------------------------------------------

#include <fstream>

using namespace std;

#include "rnd.h"

//------------------------------------------------------------------------------
// структура, обобщающая все имеющиеся фигуры
class Shape {
protected:
    enum color {
        RED = 0, ORANGE, YELLOW, GREEN, BLUE, DARK_BLUE, VIOLET
    };
    int color_index;
public:
    virtual ~Shape() {};

    // Ввод обобщенной фигуры
    static Shape *StaticIn(ifstream &ifdt);

    // Ввод обобщенной фигуры
    virtual void In(ifstream &ifdt) = 0;

    // Случайный ввод обобщенной фигуры
    static Shape *StaticInRnd();

    // Виртуальный метод ввода случайной фигуры
    virtual void InRnd() = 0;

    // Вывод обобщенной фигуры
    virtual void Out(ofstream &ofst) = 0;

    // Вычисление плоащди обобщенной фигуры
    virtual double Area() = 0;
};


#endif //ACS_HW2_SHAPE_H
