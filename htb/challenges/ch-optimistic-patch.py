from pwn import *

#context.log_level = 'DEBUG'
#context(os='linux', arch='amd64')


log.info('p')

optimistic = ELF('/home/kali/Downloads/optimistic')

#for cur_address in list(optimistic.search("P0wn3dBot")):
    # Notice that the names are the same length... We don't want to mess up our offsets or overwrite
    # other data here.
    #optimistic.write(cur_address, "P0wn3dB0t")

optimistic.asm(elf.symbols['alarm'], 'ret')

optimistic.save('/home/kali/Downloads/optimistic_patched')
