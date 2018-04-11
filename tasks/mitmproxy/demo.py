"""
This script replaces all images passing through the proxy by a Frida logo.
"""
from mitmproxy import http


def response(flow: http.HTTPFlow) -> None:
    if flow.response.headers.get("content-type", "").startswith("image"):
        img_data = open("demo.payload", "rb").read()
        flow.response.content = img_data
        flow.response.headers["content-type"] = "image/png"
