import sys
import socket
import getopt
import threading
import subprocess

# global variables
listen              = False
command             = False
upload              = False
execute             = ""
target              = ""
upload_destination  = ""
port                = 0

# functio to handle command-lien arguments

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

#usage()

def client_sender(buffer):
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        # connect to our target host
        client.connect((target,port))

        if len(buffer):
            client.send(buffer)

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


def server_loop():
    global target

    #if no target is defined , listen on all interfacs

    if not len(target):
        target ="0.0.0.0"

    server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    server.bind((target,port))
    server.listen(5)

    while True:
        client_socket, addr = socket.accept()

        #spin threads to handle our new client_socket
        client_thread = threading.Thread(target=client_handler,args=(client_socket))

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

def client_handler(client_socket):
    global upload
    global execute
    global command

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

    if command:
        while True:
            # show a simple prompt
            client_socket.send("Rcat:#> ")
            #receive data until a linefeed (enter key)
            cmd_bufer=""
            while "\n" not in cmd_bufer:
                cmd_bufer+=client_socket.recv(1024)

            #send back the command output

            response = run_command(cmd_bufer)
            #send back the response
            client_socket.send(response)

def main():
    global listen
    global port
    global execute
    global command
    global upload_destination
    global target

    if not len(sys.argv[1:]):
        usage()

    # reading command line options

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
        elif o in ("-c","--commandshell"):
            command = True
        elif o in ("-e","--execute"):
            execute = a
        elif o in ("-u","--upload"):
            upload_destination = a
        elif o in ("-t","--target"):
            target = a
        elif o in ("-p","--port"):
            port = int(a)
        else:
            assert False, "Unhandelled option"

        #are u going to listen or just send data
        if not listen and len(target) and port > 0:
            # read in the buffer from the commandline
            # this will bock , so send CTRL-D if not sending input
            #to stdin

            buffer  = sys.stdin.read()

            # send data off
            client_sender(buffer)

        # we are rgoing to listen and potentially  upload things
        #execute comands, and drop a shell back depending on our line options

        if listen:
            server_loop()
main();
