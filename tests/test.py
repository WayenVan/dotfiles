from typing import List, Tuple, Dict, Any, Union
from numpy import array, ndarray

a = 0
for i in range(10):
    a = a + 1
    print(i)

a = 1
b = 2
c = 3
d = 4
e = 5


class Test:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y

    def add(self):
        return self.x + self.y
