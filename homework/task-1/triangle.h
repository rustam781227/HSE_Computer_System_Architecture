//
// Created by Rusta on 30.01.2022.
//

#ifndef ACS_HW1_TRIANGLE_H
#define ACS_HW1_TRIANGLE_H

//------------------------------------------------------------------------------
// triangle.h - содержит описание треугольника
//------------------------------------------------------------------------------

#include <fstream>
# include "rnd.h"
using namespace std;
//------------------------------------------------------------------------------
// треугольник
struct triangle {
    int x1, x2, x3, y1, y2, y3; // координаты вершин
    enum color{RED = 0, ORANGE, YELLOW, GREEN, BLUE, DARK_BLUE, VIOLET};
    int color_index;
};

// Ввод параметров треугольника из файла
void In(triangle &t, std::ifstream &ifst);

// Случайный ввод параметров треугольника
void InRnd(triangle &t);

// Вывод параметров треугольника в форматируемый поток
void Out(triangle &t, std::ofstream &ofst);

// Вычисление периметра треугольника
double Area(triangle &t);

#endif //ACS_HW1_TRIANGLE_H
