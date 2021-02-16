from pwn import *
import os

#context.log_level = 'DEBUG'
#context(os='linux', arch='amd64')


log.info('p')

optimistic = ELF('/home/kali/Downloads/optimistic')

#for cur_address in list(optimistic.search("P0wn3dBot")):
    # Notice that the names are the same length... We don't want to mess up our offsets or overwrite
    # other data here.
    #optimistic.write(cur_address, "P0wn3dB0t")

optimistic.asm(optimistic.symbols['alarm'], 'ret')
#optimistic.asm(optimistic.symbols['set_key'], 'mov eax,%s\nret\n' % (hex(82783732673839 & 0xFFFFFFFF)))

optimistic.save('/home/kali/Downloads/optimistic_patched')

os.system('chmod +x /home/kali/Downloads/optimistic_patched')
