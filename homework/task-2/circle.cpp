//------------------------------------------------------------------------------
// circle_In.cpp - содержит процедуру ввода параметров
// для уже созданного круга
//------------------------------------------------------------------------------

#include "circle.h"


// Ввод параметров треугольника из файла
void Circle::In(ifstream &ifst) {
    ifst >> x1 >> y1 >> radius >> color_index;

    if (radius <= 0) {
        throw invalid_argument("Circle radius is less then zero");
    }
}

// Случайный ввод круга треугольника
void Circle::InRnd() {
    x1 = Random(-100, 100);
    y1 = Random(-100, 100);
    radius = Random(1, 100);
    while (Area() == 0) {
        radius = Random(1, 100);
    }
    color_index = Random(0, 6);
}

// Вывод параметров круга в форматируемый поток
void Circle::Out(ofstream &ofst) {
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
    }
    ofst << "It is circle: (x1, x2) = (" << x1
         << ", " << y1 << ") with radius = "
         << radius << ". Color: " << color << ". Area = " << Area() << endl;
}

// Вычисление площади круга
double Circle::Area() {
    return 3.141592653589793 * radius * radius;
}
