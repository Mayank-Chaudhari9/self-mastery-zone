##  working client_server combind code
##  first listen on some port by
# client_server.py -l -p 9999
# then run in cliet mode by following sommand
# client_server.py -t 127.0.0.1 -p 9999
# press CTRL-D  for stop waiting for input 

import sys
import socket
import getopt
import threading
import subprocess

socket.setdefaulttimeout(150)

# global variables
listen              = False
command             = False
upload              = False
execute             = ""
target              = ""
upload_destination  = ""
port                = 0
#server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

#server.bind((bind_ip,bind_port))

#server.listen(5)

#print"[*] Server listening on %s:%d" % (bind_ip,bind_port)
def usage():
    print "Rcat Network Tool"
    print
    print "Usage: Rcat.py -t target_host -p port"
    print "-l --listen               -listen on[host]:[port] for incomming connections"
    print "-e --execute=file_to_run  - execute the given file upon receiving a connection"
    print "-c --command              - initialize a command shell"
    print "-u --upload=destination   - upon receiving connection upload a file  and write to                           [destination]"
    print
    print
    print "Examples: "
    print "Rcat.py -t 192.168.0.1 -p 5555 -l -c"
    print "Rcat.py -t 192.168.0.1 -p 5555 -l -u=c:\\target.exe"
    print "Rcat.py -t 192.168.0.1 -p 5555 -l -e=\"cat /etc/passwd\""
    print "echo 'ABCDEFGHI' | ./Rcat.py -t 192.168.11.12 -p 135"
    sys.exit(0)


def server_loop():
    global target
    #global port
    #port = 9999

    if not len(target):
        target ="0.0.0.0"

    print port
    print target

    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    #server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((target,port))

    server.listen(5)
    print"[*] Server listening on %s:%d" % (target,port)

    while True:
        client_socket,addr =server.accept()
        print "[*] Connection accepted from : %s : %d" % (addr[0],addr[1])

        #spinning client thread to handle incoming data
        client_handler = threading.Thread(target=c_handler,args=(client_socket,))
        client_handler.start()
        #c_handler(client_socket)



# handeling logic for client

def c_handler(client_socket):
    print "rhis is called"
    # printing client data
    request = client_socket.recv(1024)

    print "[*] Received: %s " % request

    # sending  back packet
    client_socket.send("ACK")

    client_socket.close()




def client_stub():
    global target
    global port
    print port

    client = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    client.connect((target,port))
    #print "sending 'testing message to server'"
    client.send("testing message")

    # receiving back the data
    response = client.recv(4096)

    print response


def main():
    global listen
    global port
    global execute
    global command
    global upload_destination
    global target

    try:
            opts,args = getopt.getopt(sys.argv[1:],"hle:t:p:cu:",
            ["help","listen","execute","target","port","command","upoad"])
    except getopt.GetoptError as err:
            print sttr(err)
            usage()


    for o,a in opts:
            if o in ("-h","--help"):
                usage()
            elif o in ("-l","--listen"):
                listen = True
            elif o in ("-e", "--execute"):
                execute = a
            elif o in ("-c", "--commandshell"):
                command = True
            elif o in ("-u", "--upload"):
                upload_destination = a
            elif o in ("-t", "--target"):
                target = a
            elif o in ("-p", "--port"):
                port = int(a)
            else:
                assert False,"Unhandled Option"

    print port
        #are u going to listen or just send data
    if not listen and len(target) and port > 0:
            # read in the buffer from the commandline
            # this will bock , so send CTRL-D if not sending input
            #to stdin

            buffer  = sys.stdin.read()

            # send data off
            #client_sender(buffer)
            client_stub()

        # we are rgoing to listen and potentially  upload things
        #execute comands, and drop a shell back depending on our line options

    if listen:
            server_loop()

main()
