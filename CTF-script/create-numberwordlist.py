
wordlist = "numberlist.txt"
with open(wordlist, "w") as f:
    for i in range(1, 999):
        f.write("{:03d}\n".format(i))


