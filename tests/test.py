import math
import sys
import numpy as np

print(sys.executable)
print(sys.version)


def test_my():
    for i in range(10):
        a = math.sqrt(i)
        if i == 5:
            raise ValueError("i = 4")
