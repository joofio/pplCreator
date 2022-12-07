from os import listdir, getcwd, mkdir, rmdir, remove
from os.path import isfile, join, exists
import glob
from jinja2 import Template, Environment, FileSystemLoader
import pandas as pd
from pathlib import Path
import numpy as np
import sys
import uuid
import re
import openpyxl


df = pd.read_excel("Amlodipine/SPOR-Lists-EE/200000000014.xlsx", header=2)
# print(df)

print(df[df["RMS nimi eesti keeles"] == "Tablett"]["RMS termini id"].values[0])
