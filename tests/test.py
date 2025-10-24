import numpy as np
from typing import List
from transformers.models.gemma3.modeling_gemma3 import Gemma3ForCausalLM


for i in range(4):
    print(i)
    if i == 5:
        break

a = np.array([1, 2, 3])


class A:
    def __init__(self, a):
        self.a: int = a
        self.test_var: np.ndarray = np.array([1, 2, 3])
        self.b: List[int] = [1, 2, 3]

    def __repr__(self):
        self.a
        return f"A({self.a})"

    def __str__(self):
        self.test_var
        self.test_var_sum = np.sum(self.test_var)
        return f"A with value {self.a}, test_var sum: {self.test_var_sum}"
