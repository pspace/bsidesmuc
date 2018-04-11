import frida
import time


def init_frida(app, js_source):
    # setup Frida for the specified app
    js_payload = ""

    # read the javascript and store it in js_payload
    with open(js_source) as src:
        js_payload = src.read()

    # connect Frida to the emulator/android device
    device = frida.get_usb_device()

    # attach to the target
    session = device.attach(app)
    # inject payload
    script = session.create_script(js_payload)
    # return handler for the injected script
    return script


def interactive_input(msg):

    response = input("Replace \"{}\": ".format(msg))
    return response


def on_message(message, data):
    print("Request received!")

    if message['type'] == u'send':
        time.sleep(1)
        user_content = interactive_input(message['payload'])
        response = {'type': u'input', u'payload': user_content}
        script.post(response)

    else:
        # Something went wrong
        print("Unexpected message received:")
        for key in message.keys():
            print(key + ": " + str(message[key]))


app = "space.polylog.owasp.needleremover"
js_source = "text.js"
script = init_frida(app, js_source)

# register a function for handling message events with Frida
script.on('message', on_message)
# start 
script.load()

# we do not want to exit
while True:
    time.sleep(1)