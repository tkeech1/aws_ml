
import numpy as np

def normalize(np_array):
    low = np_array.min()
    high = np_array.max()
    np_array -= low
    np_array /= ( high - low )
    return np_array
