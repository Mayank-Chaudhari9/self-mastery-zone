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
        #this is working
        #client_handler = threading.Thread(target=c_handler,args=(client_socket,))
        #client_handler.start()
        #c_handler(client_socket)


        # call to testing client_handler
        client_thread = threading.Thread(target=client_handler,args=(client_socket,))
        client_thread.start()






# working handeling logic for client

def c_handler(client_socket):
    print "rhis is called"
    # printing client data
    request = client_socket.recv(1024)

    print "[*] Received: %s " % request

    # sending  back packet
    client_socket.send("ACK")

    client_socket.close()


#command execution logic
def run_command(command):
     # trim the newlne
     command = command.rstrip()

     # run the command and get the output back
     try :
         output = subprocess.check_output(command,stderr=subprocess.STDOUT,shell=True)
     except :
         output = "Failled to execute command.\r\n"

     #send the output backto the client_socket
     return output

#--------------------------------------------------------------------
# testing client _handeling with additional functionality

def client_handler(client_socket):
    global upload
    global execute
    global command

    #print "inside client handler"
    #check for upload
    if len(upload_destination):
        # read all bytes and write to deatination
        file_buffer = ""

        # keep reading data until none is available
        while  True:
            data = client_socket.recv(1024)

            if not data :
                break
            else :
                file_buffer+=data

        # now take the buffer and write them output
        try:
            file_descriptor =open(upload_destination,"wb")
            file_descriptor.write(file_buffer)
            file_descriptor.close()

            #acknowledge we wrote the file output
            client_socket.send("Successfully saved to %s\r\n"% upload_destination)
        except:
            client_socket.send("Failled to save file to %s\t\n"% upload_destination)

    #check for command execution
    if len(execute):
        # run the command
        output = run_command(execute)
        client_socket.send(output)
    #if command shell is requested
    #print command
    #client_socket.send("i am in client handler")
    if command:
        #print "inside if"
        while True:
            print "inside while"
            # show a simple prompt
            client_socket.send("<Rcat:#>")
            #receive data until a linefeed (enter key)
            cmd_bufer=""
            while "\n" not in cmd_bufer:
                cmd_bufer+=client_socket.recv(1024)

            #send back the command output

            response = run_command(cmd_bufer)
            #send back the response
            client_socket.send(response)



# testing code with client_sender --- adding functionality to client stub

def client_sender(buffer):
    global target
    global port

    client = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    print port,target
    try:
        # connect to our target host
        client.connect((target,port))
        #print "connected"
        if len(buffer):
            client.send(buffer)
        #print "working fine till here"
        while True:
            # wait for some response
            recv_len=1
            response=""

            while  recv_len:
                data     = client.recv(4096)
                recv_len = len(data)
                response+= data

                if recv_len < 4096:
                    break

        print response,
        #wait for more input
        buffer = raw_input("")
        buffer +="\n"
        #send to client
        client.send(bufer)

    except:
        print "[*] Exception ! Exiting."

        # tear down the connection
    client.close()


##------------------------------------------------------
# code with client stub working fine
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

    #print port
    #print command
        #are u going to listen or just send data
    if not listen and len(target) and port > 0:
            # read in the buffer from the commandline
            # this will block , so send CTRL-D if not sending input to stdin


            buffer  = sys.stdin.read()

            # send data off
            client_sender(buffer)

            #client_stub()

        # we are rgoing to listen and potentially  upload things
        #execute comands, and drop a shell back depending on our line options

    if listen:
            server_loop()

main()
