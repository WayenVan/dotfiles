import numpy as np
import pandas as pd


for i in range(4):
    print(i)
    if i == 5:
        break

a = np.array([1, 2, 3])


class A:
    def __init__(self, a):
        self.a: int = a

    def __repr__(self):
        self.a
        return f"A({self.a})"

    def __str__(self):
        return f"A with value {self.a}"
