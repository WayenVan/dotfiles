from statsmodels.sandbox.distributions.multivariate import df
import numpy as np


for action in range(100):
    print(action)


class A:
    def __init__(self, a: int):
        self.av = a
        self.pi: float = 3.14
        self.test_var: np.ndarray = np.array([1, 2, 3])

        return f"A({self.av})"

    def __str__(self):
        self.test_var_sum = np.sum(self.test_var)
        return f"A with value {self.av}, test_var sum: {self.test_var_sum}"
