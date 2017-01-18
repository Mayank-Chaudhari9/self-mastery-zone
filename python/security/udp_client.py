import socket

target_host = "127.0.0.1"
target_port=80

client = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
#sending data
client.sendto("AAABBBCCC",(target_host,target_port))
#receiving data
data, addr =client.recvfrom(4096)

print data
