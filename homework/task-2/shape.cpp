//------------------------------------------------------------------------------
// shape.cpp - содержит процедуры связанные с обработкой обобщенной фигуры
// и создания произвольной фигуры
//------------------------------------------------------------------------------

#include "shape.h"
#include "rectangle.h"
#include "triangle.h"
#include "circle.h"


//------------------------------------------------------------------------------
// Ввод параметров обобщенной фигуры из файла
Shape *Shape::StaticIn(ifstream &ifst) {
    int k;
    ifst >> k;
    Shape *sp = nullptr;
    switch (k) {
        case 1:
            sp = new Rectangle;
            break;
        case 2:
            sp = new Triangle;
            break;
        case 3:
            sp = new Circle;
            break;
        default:
            return nullptr;
    }
    sp->In(ifst);
    return sp;
}

// Случайный ввод обобщенной фигуры
Shape *Shape::StaticInRnd() {
    auto k = Random(1, 3);
    Shape *sp = nullptr;
    switch (k) {
        case 1:
            sp = new Rectangle;
            break;
        case 2:
            sp = new Triangle;
            break;
        case 3:
            sp = new Circle;
            break;
    }
    sp->InRnd();
    return sp;
}


