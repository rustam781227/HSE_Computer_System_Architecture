import math
import random

from shape import *


class Circle(Shape):
    def __init__(self):
        self.x1 = 0
        self.y1 = 0
        self.radius = 0
        self.color = 0

    def set(self, arr):
        self.x1 = arr[0]
        self.y1 = arr[1]
        self.radius = arr[2]
        if self.area() <= 0:
            raise ValueError("Площадь круга меньше нуля.")
        self.color = arr[3]

    def random_parameters(self):
        self.x1 = random.randint(-100, 100)
        self.y1 = random.randint(-100, 100)
        self.radius = random.randint(1, 100)
        self.color = random.randint(1, 7)

    def print(self):
        print(
            f"Circle: center = ({self.x1}, {self.y1}), radius = {self.radius},"
            f" color = {Shape.get_color(self.color)}, area = {self.area()}")

    def write(self, ostream):
        ostream.write(
            f"Circle: center = ({self.x1}, {self.y1}), radius = {self.radius},"
            f" color = {Shape.get_color(self.color)}, area = {self.area()}")

    def area(self):
        return math.pi * self.radius ** 2
