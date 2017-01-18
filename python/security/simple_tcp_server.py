import socket
import threading

bind_ip ="0.0.0.0"
bind_port= 9991

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server.bind((bind_ip,bind_port))

server.listen(5)

print"[*] Server listening on %s:%d" % (bind_ip,bind_port)

# handeling logic for client

def c_handler(client_socket):
    # printing client data
    request = client_socket.recv(1024)

    print "[*] Received: %s " % request

    # sending  back packet
    client_socket.send("ACK")

    client_socket.close()

while True:
    client,addr =server.accept()
    print "[*] Connection accepted from : %s : %d" % (addr[0],addr[1])

    #spinning client thread to handle incoming data
    client_handler = threading.Thread(target=c_handler,args=(client,))
    client_handler.start()
