
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

elf = context.binary = ELF('/home/kali/Downloads/reg')

#info("symbols = %#x", hex(elf.symbols[b'run']))

#info("plt = %#x", hex(elf.plt[b'run']))

info("%#x target", elf.symbols.run)
