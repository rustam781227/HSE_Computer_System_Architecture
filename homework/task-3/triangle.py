import math
import random

from shape import *


class Triangle(Shape):
    def __init__(self):
        self.x1 = 0
        self.y1 = 0
        self.x2 = 0
        self.y2 = 0
        self.x3 = 0
        self.y3 = 0
        self.color = 0

    def set(self, arr):
        self.x1 = arr[0]
        self.y1 = arr[1]
        self.x2 = arr[2]
        self.y2 = arr[3]
        self.x3 = arr[4]
        self.y3 = arr[5]
        if self.area() <= 0:
            raise ValueError("Площадь треугольника меньше нуля.")
        self.color = arr[6]

    def random_parameters(self):
        self.x1 = random.randint(-100, 100)
        self.y1 = random.randint(-100, 100)
        self.x2 = random.randint(-100, 100)
        self.y2 = random.randint(-100, 100)
        self.x3 = random.randint(-100, 100)
        self.y3 = random.randint(-100, 100)
        while self.area() == 0:
            self.x3 = random.randint(-100, 100)
            self.y3 = random.randint(-100, 100)
        self.color = random.randint(1, 7)

    def print(self):
        print(
            f"Triangle: (x1, y1) = ({self.x1}, {self.y1}), (x2, y2) = ({self.x2}, {self.y2}),"
            f" (x3, y3) = ({self.x3}, {self.y3}), color = {Shape.get_color(self.color)}, area = {self.area()}")

    def write(self, ostream):
        ostream.write(
            f"Triangle: (x1, y1) = ({self.x1}, {self.y1}), (x2, y2) = ({self.x2}, {self.y2}),"
            f" (x3, y3) = ({self.x3}, {self.y3}), color = {Shape.get_color(self.color)}, area = {self.area()}")

    def area(self):
        a = math.sqrt((self.x2 - self.x1) ** 2 + (self.y2 - self.y1) ** 2)
        b = math.sqrt((self.x3 - self.x2) ** 2 + (self.y3 - self.y2) ** 2)
        c = math.sqrt((self.x1 - self.x3) ** 2 + (self.y1 - self.y3) ** 2)
        p = (a + b + c) / 2
        return math.sqrt(p * (p - a) * (p - b) * (p - c))
