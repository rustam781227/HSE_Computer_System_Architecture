//
// Created by Rusta on 31.01.2022.
//

#ifndef ACS_HW2_RND_H
#define ACS_HW2_RND_H

#include <cstdlib>

//------------------------------------------------------------------------------
// rnd.h - содержит генератор случайных чисел в диапазоне
//------------------------------------------------------------------------------

inline auto Random(int a = 1, int b = 20) {
    return a + (rand() % (abs((a - b)) + 1));
}

#endif //ACS_HW2_RND_H
