from __future__ import print_function
import frida
import sys
import time

def interactive_input(msg):
  '''Read the input from stdin and return it to the caller'''
    response = raw_input("Replace \"{}\": ".format(msg))
    return response


#your content goes here