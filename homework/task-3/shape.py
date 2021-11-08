import typing


class Shape:
    def print(self):
        pass

    def write(self, ostream: typing.IO):
        pass

    def set(self, arr: typing.List[int]):
        pass

    def random_parameters(self):
        pass

    def area(self):
        pass

    @staticmethod
    def get_color(color: int):
        if color == 1:
            return "red"
        if color == 2:
            return "orange"
        if color == 3:
            return "yellow"
        if color == 4:
            return "green"
        if color == 5:
            return "blue"
        if color == 6:
            return "dark blue"
        if color == 7:
            return "violet"
        return ""
