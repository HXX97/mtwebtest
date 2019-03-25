import os
import sys
import re


if __name__ == "__main__":
   fin = open(sys.argv[1],'rU')
   fout = open(sys.argv[2],'w')
   id = 1
   while True:
       line = fin.readline()
       if line:
           match = re.search('(<seg.*?>)(.*)(</seg>)',line)
           if match:
             text = match.group(2)
             fout.write(text+" (" + str(id) +")\n")
             id += 1
       else:
           break
   fin.close()
   fout.close()
   