from IPython import get_ipython
import magnify as mg
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy as sp
import xarray as xr

ipy = get_ipython()
ipy.run_line_magic("load_ext", "autoreload")
ipy.run_line_magic("autoreload", "2")

