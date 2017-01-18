import math

signal=9
noise=10.0
ratio=signal/noise
decibals=10*math.log10(ratio)
print decibals
