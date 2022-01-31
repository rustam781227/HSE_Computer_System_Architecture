//------------------------------------------------------------------------------
// rectangle_In.cpp - содержит процедуру ввода параметров
// для уже созданного прямоугольника
//------------------------------------------------------------------------------

#include "rectangle.h"

//------------------------------------------------------------------------------
// Ввод параметров прямоугольника из файла
void Rectangle::In(ifstream &ifst) {
    ifst >> x1 >> y1 >> x2 >> y2 >> color_index;
    if (x1 >= x2 || y1 <= y2) {
        throw invalid_argument("Rectangles' left point should be upper and lefter, than right point");
    }
}

// Случайный ввод параметров прямоугольника
void Rectangle::InRnd() {
    x1 = Random(-100, 100);
    y1 = Random(-100, 100);
    x2 = Random(x1, 100);
    y2 = Random(-100, y1);
    while (Area() == 0) {
        x2 = Random(x1, 100) + 1;
        y2 = Random(-100, y1) - 1;
    }
    color_index = Random(0, 6);
}

//------------------------------------------------------------------------------
// Вывод параметров прямоугольника в форматируемый поток
void Rectangle::Out(ofstream &ofst) {
    string color;
    // Находим нужный цвет в перичислении.
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
    ofst << "It is Rectangle: (x1, y1) = (" << x1 << ", "
         << y1 << ") (x2, y2)= (" << x2 << ", " << y2
         << "). Color: " << color << ". Area = " << Area() << "\n";
}

//------------------------------------------------------------------------------
// Вычисление площади прямоугольника
double Rectangle::Area() {
    return std::abs(x2 - x1) * std::abs(y1 - y2);
}
