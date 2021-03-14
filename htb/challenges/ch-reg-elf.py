
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

elf = ELF('/home/kali/Downloads/reg')

info("symbols = %#x", hex(elf.symbols[b'run']))

info("plt = %#x", hex(elf.plt[b'run']))

