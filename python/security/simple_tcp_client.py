import socket
target_host= "www.google.com"
target_port=80

# creating  a socket object

client = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

#connecting the client

client.connect((target_host,target_port))

#sending some data

client.send("GET / HTTP/1.1\r\nHost: google.com\r\n\r\n")

# receiving back the data
response = client.recv(4096)

print response
