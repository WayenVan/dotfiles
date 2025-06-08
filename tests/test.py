from tarfile import data_filter
import numpy as np
from typing import List, Dict, Any


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
