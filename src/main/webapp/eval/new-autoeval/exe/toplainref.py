import os
import sys
import re
import codecs

if __name__ == "__main__":
   fin = open(sys.argv[1],'rU')
   fout = open(sys.argv[2],'w')
   
   ref = fin.read()
   refcount = ref.count('</DOC>')
   count = ref.count('</seg>') / refcount
   fin.seek(0)
   reflist = fin.readlines()
   start = []
   id = 0
   for line in reflist:
      if line[:3] == codecs.BOM_UTF8:
         line = line[3:]
      if line.startswith('<DOC'):
         start.append(id)
      id += 1
   
   id = 1
   
   
   while (id <= count):
       for i in range(refcount):
         while True:
           match = re.search('(<seg.*?>)(.*)(</seg>)',reflist[start[i]])
           if match:
              text = match.group(2)
              fout.write(text+" (" + str(id) +")\n")
              start[i] += 1
              break
           else:
              start[i] += 1
       id += 1
   
   fin.close()
   fout.close()
