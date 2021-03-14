
from pwn import *

context.log_level = 'DEBUG'
context(os='linux', arch='amd64')
context.terminal = ["tmux", "splitw", "-h"]

padding_length = 56
ret_offset = -96

log.info('Create IO')
#io = remote('', )
io = process('/home/kali/Downloads/reg')
pid = gdb.attach(io, '''
set follow-fork-mode child
break *(main)
continue
''')


payload = cyclic(200)

log.info('Send Payload')
io.sendlineafter('name : ', payload)

io.interactive()
