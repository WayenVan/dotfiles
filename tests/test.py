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


def add(a, b):
    return a + b


# pivot sort
def pivot_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[0]
    left = [x for x in arr[1:] if x < pivot]

    right = [x for x in arr[1:] if x >= pivot]

    return pivot_sort(left) + [pivot] + pivot_sort(right)
