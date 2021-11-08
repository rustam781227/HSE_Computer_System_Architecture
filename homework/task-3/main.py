import datetime
import sys

from container import *


def get_filled_container():
    if len(sys.argv) != 5:
        print("Incorrect number of arguments!")
        exit()

    if sys.argv[1] == "-f":
        in_file = sys.argv[2]
        try:
            container = Container()
            container.fill(in_file)
            container.print()
        except Exception as e:
            print(e)
            exit()
    elif sys.argv[1] == "-r":
        num = int(sys.argv[2])
        if not 0 < num <= 10000:
            print(f"Incorrect number of objects!")
            exit()
        container = Container()
        container.fill_random(num)
        container.print()

    else:
        print("Incorrect command line arguments!")
        exit()
    return container


if __name__ == '__main__':
    start_time = datetime.datetime.now()
    container = get_filled_container()

    out_file1 = sys.argv[3]
    out_file2 = sys.argv[4]

    print('Start')

    ofile = open(out_file1, 'w')
    container.write(ofile)
    ofile.close()

    ofile = open(out_file2, 'w')
    container.bubble_sort()
    ofile.write("Sorted container:\n")
    container.write(ofile)
    ofile.close()

    print('The End')
    print(datetime.datetime.now() - start_time)
