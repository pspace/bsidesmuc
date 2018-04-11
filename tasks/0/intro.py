# ######################### PYTHON ##################
import frida
import sys

# Attach to binary
session = frida.attach("test")
# read JS payload from file
js_content = open("intro.js").read()

address = sys.argv[1]
js_content_with_address = js_content.replace("ADDRESS", address)

# init Frida script with JS
script = session.create_script(js_content_with_address)

# Start & keep running
script.load()
sys.stdin.read()