
import numpy as np

def normalize(np_array):
    low = np_array.min()                         
    high = np_array.max()                        
    return ( np_array - low ) / ( high - low )   
