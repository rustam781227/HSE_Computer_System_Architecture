#include <iostream>
#include <fstream>
#include <cstdlib> // для функций rand() и srand()
#include <ctime>   // для функции time()
#include <cstring>
#include "container.h"

void errMessage1() {
    printf( "incorrect command line!\n"
            "  Waited:\n"
            "     command -f infile outfile01 outfile02\n"
            "  Or:\n"
            "     command -n number outfile01 outfile02\n");
}

void errMessage2() {
    printf("incorrect qualifier value!\n"
           "  Waited:\n"
           "     command -f infile outfile01 outfile02\n"
           "  Or:\n"
           "     command -n number outfile01 outfile02\n");
}

//------------------------------------------------------------------------------
int main(int argc, char* argv[]) {
    if(argc != 5) {
        errMessage1();
        return 1;
    }

    printf("Start\n");
    container c;
    Init(c);

    if(!strcmp(argv[1], "-f")) {
        std::ifstream ifst(argv[2]);
        try {
            In(c, ifst);
        }
        catch (std::invalid_argument e){
            printf(e.what());
            return 3;
        }
    }
    else if(!strcmp(argv[1], "-n")) {
        auto size = atoi(argv[2]);
        if((size < 1) || (size > 10000)) {
            printf("%s %i %s",
                   "incorrect numer of figures =", size,
                   ". Set 0 < number <= 10000\n");
            return 3;
        }
        // системные часы в качестве инициализатора
        srand(static_cast<unsigned int>(time(0)));
        // Заполнение контейнера генератором случайных чисел
        InRnd(c, size);
    }
    else {
        errMessage2();
        return 2;
    }

    // Вывод содержимого контейнера в файл
    std::ofstream ofst1(argv[3]);
    ofst1 << "Filled container:\n";
    Out(c, ofst1);

    std::ofstream ofst2(argv[4]);
    BubbleSort(c);
    ofst2 << "Sorted container:\n";
    Out(c, ofst2);

    Clear(c);
    printf("Stop\n");
    return 0;
}
