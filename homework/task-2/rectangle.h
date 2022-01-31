//
// Created by Rusta on 31.01.2022.
//

#ifndef ACS_HW2_RECTANGLE_H
#define ACS_HW2_RECTANGLE_H

//------------------------------------------------------------------------------
// rectangle.h - содержит описание прямоугольника  и его интерфейса
//------------------------------------------------------------------------------

#include <fstream>

using namespace std;

# include "rnd.h"
#include "shape.h"

// прямоугольник
class Rectangle : public Shape {
public:
    virtual ~Rectangle() {}

    // Ввод параметров прямоугольника из файла
    virtual void In(ifstream &ifst);

    // Случайный ввод параметров прямоугольника
    virtual void InRnd();

    // Вывод параметров прямоугольника в форматируемый поток
    virtual void Out(ofstream &ofst);

    // Вычисление площади прямоугольника
    virtual double Area();

private:
    int x1, y1, x2, y2; // Координаты левого верхнего угла
};


#endif //ACS_HW2_RECTANGLE_H
