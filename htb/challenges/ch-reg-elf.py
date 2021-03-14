
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

elf = context.binary = ELF('/home/kali/Downloads/reg')

#info("symbols = %#x", hex(elf.symbols[b'run']))

#info("plt = %#x", hex(elf.plt[b'run']))

info("%#x run", elf.symbols.run)

info("%#x winner", elf.symbols.winner)

info("%s plt", elf.plt)

info("%s got", elf.got)
