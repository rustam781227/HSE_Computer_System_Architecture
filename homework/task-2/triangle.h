//
// Created by Rusta on 31.01.2022.
//

#ifndef ACS_HW2_TRIANGLE_H
#define ACS_HW2_TRIANGLE_H

//------------------------------------------------------------------------------
// triangle.h - содержит описание треугольника
//------------------------------------------------------------------------------

#include <fstream>

using namespace std;

#include "rnd.h"
#include "shape.h"

//------------------------------------------------------------------------------
// треугольник
class Triangle : public Shape {
public:
    virtual ~Triangle() {}

    // Ввод параметров треугольника из файла
    virtual void In(ifstream &ifst);

    // Случайный ввод параметров треугольника
    virtual void InRnd();

    // Вывод параметров треугольника в форматируемый поток
    virtual void Out(ofstream &ofst);

    // Вычисление площади треугольника
    virtual double Area();

private:
    int x1, x2, x3, y1, y2, y3; // координаты вершин
};

#endif //ACS_HW2_TRIANGLE_H