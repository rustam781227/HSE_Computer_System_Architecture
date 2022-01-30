//------------------------------------------------------------------------------
// triangle.cpp - содержит функции обработки треугольника
//------------------------------------------------------------------------------

#include "triangle.h"
#include <cmath>

//------------------------------------------------------------------------------
// Ввод параметров треугольника из потока
void In(triangle &t, std::ifstream &ifst) {
    ifst >> t.x1 >> t.y1 >> t.x2 >> t.y2 >> t.x3 >> t.y3 >> t.color_index;
    if (Area(t) == 0){
        throw std::invalid_argument("Triangles' area can't be 0");
    }
}

// Случайный ввод параметров треугольника
void InRnd(triangle &t) {
    t.x1 = Random(-100, 100);
    t.y1 = Random(-100, 100);
    t.x2 = Random(-100, 100);
    t.y2 = Random(-100, 100);
    t.x3 = Random(-100, 100);
    t.y3 = Random(-100, 100);
    while (Area(t) == 0){
        t.x3 = Random(-100, 100);
        t.y3 = Random(-100, 100);
    }
    t.color_index = Random(0, 6);
}

//------------------------------------------------------------------------------
// Вывод параметров треугольника в поток
void Out(triangle &t, std::ofstream &ofst){

    std::string color;

    switch (t.color_index) {
        case t.RED:
            color = "red";
            break;
        case t.ORANGE:
            color = "orange";
            break;
        case t.YELLOW:
            color = "yellow";
            break;
        case t.GREEN:
            color = "green";
            break;
        case t.BLUE:
            color = "blue";
            break;
        case t.DARK_BLUE:
            color = "dark blue";
            break;
        case t.VIOLET:
            color = "violet";
            break;
        default:
            color = "none";
    }

    ofst << "It is Triangle: (x1, x2) = ("
         << t.x1 << ", " << t.y1 << ") (x2, y2) = ("
         << t.x2 << ", " << t.y2 << ") (x3, y3) = (" << t.x3 << ", " << t.y3
         << "). Color: " << color << ". Area = " << Area(t) << "\n";
}

//------------------------------------------------------------------------------
// Вычисление площади треугольника
double Area(triangle &t) {
    double a = std::sqrt(std::pow((t.x2 - t.x1), 2) + std::pow((t.y2 - t.y1), 2));
    double b = std::sqrt(std::pow((t.x3 - t.x2), 2) + std::pow((t.y3 - t.y2), 2));
    double c = std::sqrt(std::pow((t.x1 - t.x3), 2) + std::pow((t.y1 - t.y3), 2));
    double p = (a + b + c) / 2;
    return std::sqrt(p * (p - a) * (p - b) * (p - c));
}