from tarfile import data_filter
import numpy as np
from transformers import AutoTokenizer, AutoModelForCausalLM


for i in range(10):
    print(i)
    if i == 5:
        break
