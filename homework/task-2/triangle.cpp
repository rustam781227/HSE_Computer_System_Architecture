//------------------------------------------------------------------------------
// triangle.cpp - содержит функции обработки треугольника
//------------------------------------------------------------------------------

#include "triangle.h"
#include <cmath>

//------------------------------------------------------------------------------
// Ввод параметров треугольника из потока
void Triangle::In(ifstream &ifst) {
    ifst >> x1 >> y1 >> x2 >> y2 >> x3 >> y3 >> color_index;
    if (Area() == 0) {
        throw invalid_argument("Triangles' area can't be 0");
    }
}

// Случайный ввод параметров треугольника
void Triangle::InRnd() {
    x1 = Random(-100, 100);
    y1 = Random(-100, 100);
    x2 = Random(-100, 100);
    y2 = Random(-100, 100);
    x3 = Random(-100, 100);
    y3 = Random(-100, 100);
    while (Area() == 0) {
        x3 = Random(-100, 100);
        y3 = Random(-100, 100);
    }
    color_index = Random(0, 6);
}

//------------------------------------------------------------------------------
// Вывод параметров треугольника в поток
void Triangle::Out(ofstream &ofst) {
    string color;

    switch (color_index) {
        case RED:
            color = "red";
            break;
        case ORANGE:
            color = "orange";
            break;
        case YELLOW:
            color = "yellow";
            break;
        case GREEN:
            color = "green";
            break;
        case BLUE:
            color = "blue";
            break;
        case DARK_BLUE:
            color = "dark blue";
            break;
        case VIOLET:
            color = "violet";
            break;
        default:
            color = "none";
            break;
    }

    ofst << "It is Triangle: (x1, x2) = ("
         << x1 << ", " << y1 << ") (x2, y2) = ("
         << x2 << ", " << y2 << ") (x3, y3) = (" << x3 << ", " << y3
         << "). Color: " << color << ". Area = " << Area() << "\n";
}

//------------------------------------------------------------------------------
// Вычисление площади треугольника
double Triangle::Area() {
    double a = std::sqrt(std::pow((x2 - x1), 2) + std::pow((y2 - y1), 2));
    double b = std::sqrt(std::pow((x3 - x2), 2) + std::pow((y3 - y2), 2));
    double c = std::sqrt(std::pow((x1 - x3), 2) + std::pow((y1 - y3), 2));
    double p = (a + b + c) / 2;
    return std::sqrt(p * (p - a) * (p - b) * (p - c));
}