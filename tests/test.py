import numpy as np


for action in range(100):
    print(action)

a = np.array(
    [1, 2, 3],
)


class A:
    def __init__(self, a: int):
        self.a = a
        self.pi: float = 3.14
        self.test_var: np.ndarray = np.array([1, 2, 3])

    def __str__(self):
        self.test_var_sum = np.sum(self.test_var)
        return f"A with value {self.a}, test_var sum: {self.test_var_sum}"
