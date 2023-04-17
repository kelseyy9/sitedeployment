# read in file, remove whitespace and duplicates, print pretty
import sys

file = open("tmp2.txt", "r")
lines = file.readlines()
lineslist = []
statelist = ['State: running\n', 'State: pending\n', 'State: shutting-down\n', 'State: terminated\n', 'State: rebooting\n', 'State: stopping\n', 'State: stopped\n']

with open('pout.txt', 'a') as f:
    for i in lines:
        f.write(i.lstrip())
    f.close()
file.close()

file = open("pout.txt", "r")
with open('instances.txt', 'w') as f:
    for line in file:
        if line not in lineslist:
            f.write(line)
            if line not in statelist:
                lineslist.append(line)
file.close()
f.close()
#print(lineslist)
#with open('instances.txt', 'r') as f:
#    for line in f:
#        print(line, end="")
#f.close()
