import socket
import threading

bind_ip ="0.0.0.0"
bind_port= 9993

#server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

#server.bind((bind_ip,bind_port))

#server.listen(5)

#print"[*] Server listening on %s:%d" % (bind_ip,bind_port)

def start_server():
    global bind_ip
    global bind_port
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    server.bind((bind_ip,bind_port))

    server.listen(5)
    print"[*] Server listening on %s:%d" % (bind_ip,bind_port)

    while True:
        client,addr =server.accept()
        print "[*] Connection accepted from : %s : %d" % (addr[0],addr[1])

        #spinning client thread to handle incoming data
        client_handler = threading.Thread(target=c_handler,args=(client,))
        client_handler.start()



# handeling logic for client

def c_handler(client_socket):
    # printing client data
    request = client_socket.recv(1024)

    print "[*] Received: %s " % request

    # sending  back packet
    client_socket.send("ACK")

    client_socket.close()




def client_stub():
    global bind_ip
    global bind_port

    client = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    client.connect((bind_ip,bind_port))
    client.send("testing message")

    # receiving back the data
    response = client.recv(4096)

    print response


def main():
    global bind_ip
    global bind_port

    if not len(sys.argv[1:]):
        print "not enough arguemants"

    try:
        opts,args = getopt.getopt(sys.argv[1:],"hle:t:p:cu:",
        ["help","listen","execute","target","port","command","upoad"])
