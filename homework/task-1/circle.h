//
// Created by Rusta on 30.01.2022.
//

#ifndef ACS_HW1_CIRCLE_H
#define ACS_HW1_CIRCLE_H

//------------------------------------------------------------------------------
// circle.h - содержит описание круга
//------------------------------------------------------------------------------

#include "rnd.h"
#include <fstream>

struct circle {
    int x1, y1, radius;
    enum color{RED = 0, ORANGE, YELLOW, GREEN, BLUE, DARK_BLUE, VIOLET};
    int color_index;
};

// Ввод параметров треугольника из файла
void In(circle &c, std::ifstream &ifst);

// Случайный ввод круга треугольника
void InRnd(circle &c);

// Вывод параметров круга в форматируемый поток
void Out(circle &c, std::ofstream &ofst);

// Вычисление площади круга
double Area(circle &c);

#endif //ACS_HW1_CIRCLE_H
