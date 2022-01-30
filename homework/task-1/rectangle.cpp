//------------------------------------------------------------------------------
// rectangle_In.cpp - содержит процедуру ввода параметров 
// для уже созданного прямоугольника
//------------------------------------------------------------------------------

#include "rectangle.h"

//------------------------------------------------------------------------------
// Ввод параметров прямоугольника из файла
void In(rectangle &r, std::ifstream &ifst) {
    ifst >> r.x1 >> r.y1 >> r.x2 >> r.y2 >> r.color_index;
    if (r.x1 >= r.x2 || r.y1 <= r.y2){
        throw std::invalid_argument("Rectangles' left point should be upper and lefter, than right point");
    }
}

// Случайный ввод параметров прямоугольника
void InRnd(rectangle &r) {
    r.x1 = Random(-100, 100);
    r.y1 = Random(-100, 100);
    r.x2 = Random(r.x1, 100);
    r.y2 = Random(-100, r.y1);
    while (Area(r) == 0) {
        r.x2 = Random(r.x1, 100) + 1;
        r.y2 = Random(-100, r.y1) - 1;
    }
    r.color_index = Random(0, 6);
}

//------------------------------------------------------------------------------
// Вывод параметров прямоугольника в форматируемый поток
void Out(rectangle &r, std::ofstream &ofst) {
    std::string color;
    // Находим нужный цвет в перичислении.
    switch (r.color_index) {
        case r.RED:
            color = "red";
            break;
        case r.ORANGE:
            color = "orange";
            break;
        case r.YELLOW:
            color = "yellow";
            break;
        case r.GREEN:
            color = "green";
            break;
        case r.BLUE:
            color = "blue";
            break;
        case r.DARK_BLUE:
            color = "dark blue";
            break;
        case r.VIOLET:
            color = "violet";
            break;
        default:
            color = "none";
    }
    ofst << "It is Rectangle: (x1, y1) = (" << r.x1 << ", "
         << r.y1 << ") (x2, y2)= (" << r.x2 << ", " << r.y2
         << "). Color: " << color << ". Area = " << Area(r) << "\n";
}

//------------------------------------------------------------------------------
// Вычисление площади прямоугольника
double Area(rectangle &r) {
    return std::abs(r.x2 - r.x1) * std::abs(r.y1 - r.y2);
}
