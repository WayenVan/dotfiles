import numpy as np
from typing import List


for i in range(4):
    print(i)
    if i == 5:
        break

a = np.array([1, 2, 3])


class A:
    def __init__(self, a):
        self.a: int = a
        self.c: list[int] = [1, 2, 3]
        self.d: List[int] = [4, 5, 6]
        self.test_var: np.ndarray = np.array([1, 2, 3])

    def __repr__(self):
        return f"A({self.a})"

    def __str__(self):
        self.test_var
        self.test_var_sum = np.sum(self.test_var)
        return f"A with value {self.a}, test_var sum: {self.test_var_sum}"
