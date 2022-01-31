//
// Created by Rusta on 31.01.2022.
//

#ifndef ACS_HW2_CIRCLE_H
#define ACS_HW2_CIRCLE_H

//------------------------------------------------------------------------------
// circle.h - содержит описание круга  и его интерфейса
//------------------------------------------------------------------------------

#include <fstream>

using namespace std;

# include "rnd.h"
#include "shape.h"

class Circle : public Shape {
public:
    virtual ~Circle() {}

    // Ввод параметров прямоугольника из файла
    virtual void In(ifstream &ifst);

    // Случайный ввод параметров прямоугольника
    virtual void InRnd();

    // Вывод параметров прямоугольника в форматируемый поток
    virtual void Out(ofstream &ofst);

    // Вычисление площади прямоугольника
    virtual double Area();

private:
    int x1, y1, radius;
};


#endif //ACS_HW2_CIRCLE_H
