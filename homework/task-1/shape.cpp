//------------------------------------------------------------------------------
// shape.cpp - содержит процедуры связанные с обработкой обобщенной фигуры
// и создания произвольной фигуры
//------------------------------------------------------------------------------

#include "shape.h"

//------------------------------------------------------------------------------
// Ввод параметров обобщенной фигуры из файла

shape* In(std::ifstream &ifst) {
    shape *sp;
    int k;
    ifst >> k;
    switch(k) {
        case 1:
            sp = new shape;
            sp->k = shape::RECTANGLE;
            In(sp->r, ifst);
            return sp;
        case 2:
            sp = new shape;
            sp->k = shape::TRIANGLE;
            In(sp->t, ifst);
            return sp;
        case 3:
            sp = new shape;
            sp->k = shape::CIRCLE;
            In(sp->c, ifst);
            return sp;
        default:
            return nullptr;
    }
}

// Случайный ввод обобщенной фигуры
shape *InRnd() {
    shape *sp;
    auto k = rand() % 3 + 1;
    switch(k) {
        case 1:
            sp = new shape;
            sp->k = shape::RECTANGLE;
            InRnd(sp->r);
            return sp;
        case 2:
            sp = new shape;
            sp->k = shape::TRIANGLE;
            InRnd(sp->t);
            return sp;
        case 3:
            sp = new shape;
            sp->k = shape::CIRCLE;
            InRnd(sp->c);
            return sp;
        default:
            return nullptr;
    }
}

//------------------------------------------------------------------------------
// Вывод параметров текущей фигуры в поток
void Out(shape &s, std::ofstream &ofst) {
    switch(s.k) {
        case shape::RECTANGLE:
            Out(s.r, ofst);
            break;
        case shape::TRIANGLE:
            Out(s.t, ofst);
            break;
        case shape::CIRCLE:
            Out(s.c, ofst);
            break;
        default:
            ofst << "Incorrect figure!" << std::endl;
    }
}

//------------------------------------------------------------------------------
// Вычисление площадь фигуры
double Area(shape &s) {
    switch(s.k) {
        case shape::RECTANGLE:
            return Area(s.r);
        case shape::TRIANGLE:
            return Area(s.t);
        case shape::CIRCLE:
            return Area(s.c);
        default:
            return 0.0;
    }
}
