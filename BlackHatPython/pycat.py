import sys
import socket
import getopt
import threading
import subprocess

listen = False
command = False
upload = False
execute = ""
target = ""
upload_destination = ""
port = 0


def usage():
    print("BHP Net Tool")
    print("")
    print("Usage: pycat.py -t target_host -p port")
    print("-l --listen                  - listen on [host]:[port] for incoming connections")
    print("-e --execute=file_to_run     - execute the given file upon recieving connection")
    print("-u --upload=destination      - upon receiving connection upload a file and write to the destination")
    print("")
    print("")
    print("Examples:")
    print("pycat.py -t 10.0.0.1 -p 8080 -l -c")
    print("pycat.py -t 10.0.0.1 -p 8080 -l -u=c:\\target.exe")
    print("pycat.py -t 10.0.0.1 -p 8080 -l -e=\"cat /etc/password\"")
    print("echo 'AABBCCDD' | pycat.py -t 10.0.0.1 -p 8080")
    sys.exit(0)


def main():
    global listen
    global execute
    global upload_destination
    global port
    global target
    global command

    if not len(sys.argv[1:]):
        usage()

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hle:t:p:cu:", ["help", "listen", "execute", "target", "port", "command", "upload"])
    except getopt.GetoptError as err:
        print(str(err))
        usage()

    for o, a in opts:
        if o in ("-h", "--help"):
            usage()



