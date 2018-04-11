from __future__ import print_function
import frida
import sys
import time

class_names = []
in_progress = True


def init_frida():
    js_payload = open("enumerate_classes.js").read()
    device = frida.get_usb_device()
    session = device.attach("space.polylog.owasp.needleremover")
    script = session.create_script(js_payload)
    return script


def on_message(message, data):
    global in_progress
    global class_names

    if message['type'] == u'send':

        content = message['payload']
        print(content)
        if not content == "DONE":
            class_names.append(content)
        else:
            output = open("classList.txt", 'w')
            output.write("\n".join(sorted(class_names)))
            in_progress = False
    else:
        print("Unexpected message received:")
        for key in message.keys():
            print(key + ": " + str(message[key]))


script = init_frida()
script.on('message', on_message)
script.load()

while in_progress:
    time.sleep(1)
sys.exit()
