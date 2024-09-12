import math
import sys

print(sys.executable)
print(sys.version)

for i in range(10):
    a = math.sqrt(i)
    if i == 5:
        raise ValueError("i = 5")
    print(a)


def test():
    print("test")
