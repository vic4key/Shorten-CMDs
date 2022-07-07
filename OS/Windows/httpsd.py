from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl
import os

endpoint = ("localhost", 443)
httpd = HTTPServer(endpoint, SimpleHTTPRequestHandler)

cdir = os.path.dirname(os.path.realpath(__file__))
cert_file_path = os.path.join(cdir, "https-localhost.pem")
httpd.socket = ssl.wrap_socket(httpd.socket, certfile=cert_file_path, server_side=True)

# sslctx = ssl.SSLContext()
# sslctx.check_hostname = False # If set to True, only the hostname that matches the certificate will be accepted
# sslctx.load_cert_chain(certfile="self-signed.pem", keyfile="private.pem")
# httpd.socket = sslctx.wrap_socket(httpd.socket, server_side=True)

print("Serving HTTPS on", endpoint, "...")
httpd.serve_forever()