import sys
import math

print(sys.executable)

for i in range(10):
    a = math.sqrt(i)
    if i == 5:
        raise ValueError("i = 5")
    print(a)


def test():
    print("test")
