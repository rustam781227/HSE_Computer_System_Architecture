from random import randint
from rectangle import Rectangle
from circle import Circle
from triangle import Triangle
import typing


class Container:
    def __init__(self):
        self.container = []

    def fill_random(self, number: int):
        for i in range(number):
            figure_type = randint(1, 3)
            if figure_type == 1:
                figure = Rectangle()
            if figure_type == 2:
                figure = Triangle()
            if figure_type == 3:
                figure = Circle()
            figure.random_parameters()
            self.container.append(figure)

    def fill(self, file: str):
        with open(file, 'r') as file:
            figure_type = int(file.readline())
            while figure_type != 0:
                if figure_type == 1:
                    figure = Rectangle()
                if figure_type == 2:
                    figure = Triangle()
                if figure_type == 3:
                    figure = Circle()
                figure.set(list(map(int, file.readline().split())))
                self.container.append(figure)

                figure_type = int(file.readline())

    def print(self):
        print("There are ", len(self.container), "objects:")
        for figure in self.container:
            figure.print()

    def write(self, ostream: typing.IO):
        ostream.write(f"There are {len(self.container)} objects:\n")
        for figure in self.container:
            figure.write(ostream)
            ostream.write("\n")

    def bubble_sort(self):
        print("sorting...")
        # We can stop the iteration once the swap has done
        has_swapped = True

        while has_swapped:
            has_swapped = False
            for i in range(len(self.container) - 1):
                if self.container[i].area() > self.container[i + 1].area():
                    # Swap
                    self.container[i], self.container[i + 1] = self.container[i + 1], self.container[i]
                    has_swapped = True
