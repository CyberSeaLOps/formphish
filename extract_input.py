#!/usr/bin/python

from bs4 import BeautifulSoup # python -m pip install beautifulsoup
import requests
import sys
URL = sys.argv[1] 

try:
 content = requests.get(URL)
 soup = BeautifulSoup(content.text, 'html.parser')
except:
 print("Error, check your connection")
 
try:
 inputs=[(n['name']) for n in soup.findAll('input')]
 for inpt in inputs:
  print(inpt)
except:
 print("Error")
