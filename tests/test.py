import numpy as np


for i in range(4):
    print(i)
    if i == 5:
        break

a = np.array([1, 2, 3])


class A:
    def __init__(self, a):
        self.a = a

    def __repr__(self):
        return f"A({self.a})"

    def __str__(self):
        return f"A with value {self.a}"
