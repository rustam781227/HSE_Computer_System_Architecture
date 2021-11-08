import math
import random

from shape import *


class Rectangle(Shape):
    def __init__(self):
        self.x1 = 0
        self.y1 = 0
        self.x2 = 0
        self.y2 = 0
        self.color = 0

    def set(self, arr):
        self.x1 = arr[0]
        self.y1 = arr[1]
        self.x2 = arr[2]
        self.y2 = arr[3]
        if self.area() <= 0:
            raise ValueError("Площадь прямоугольника меньше нуля.")
        self.color = arr[4]

    def random_parameters(self):
        self.x1 = random.randint(-100, 100)
        self.y1 = random.randint(-100, 100)
        self.x2 = random.randint(self.x1, 100)
        self.y2 = random.randint(-100, self.y1)
        while self.area() == 0:
            self.x2 = random.randint(self.x1, 100) + 1
            self.y2 = random.randint(-100, self.y1) - 1
        self.color = random.randint(1, 7)

    def print(self):
        print(
            f"Rectangle: (x1, y1) = ({self.x1}, {self.y1}), (x2, y2) = ({self.x2}, {self.y2}),"
            f" color = {Shape.get_color(self.color)}, area = {self.area()}")

    def write(self, ostream):
        ostream.write(
            f"Rectangle: (x1, y1) = ({self.x1}, {self.y1}), (x2, y2) = ({self.x2}, {self.y2}),"
            f" color = {Shape.get_color(self.color)}, area = {self.area()}")

    def area(self):
        return (self.x2 - self.x1) * (self.y1 - self.y2)