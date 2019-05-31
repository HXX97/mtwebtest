import os
import sys
import re
import codecs

from xml.etree import ElementTree as ET

output = ''

#help info:
help_info = 'This python script will check the format of candidate translation file(Eng/Chn)\n\
        How to use - Python check.py candidate_filename src_filename\n\
        This program will check the format of candi file:\n\
        <?xml version="1.0" encoding="UTF-8"?>\n\
        <tstset setid="zh_en_news_trans" srclang="zh" trglang="en">\n\
        <system site="name of participant" sysid="name of system">\n\
        ...\n\
        </system>\n\
        <DOC docid="name of document" sysid="***">\n\
        <p>\n\
        <seg id="1">A narrow  has become   town farmers Zhang  ( 58 years old ) temporary home , and in this &quot; family &quot; of the Central Committee , suspended from a picture with delicate frame portrait </seg>\n\
        ...\n\
        </p>\n\
        ...\n\
        </DOC>\n\
        </tstset>\n\
        It will also check whether you generate an escape sequence, also, the sentence number of source and target file should be equal. System info should be at least 60 bytes.'


def getFileNames(directory, fileExtention):
    "get list of files of particular extentions"

    fileNameList = [os.path.normcase(f) for f in os.listdir(directory)]
    fileNameList = [
        os.path.splitext(f)[0] for f in fileNameList
        if os.path.splitext(f)[1] == fileExtention
    ]
    return fileNameList


def check(filename):
    #check whether the xml input is well-formed.
    global output
    fout = open(output + '_log.txt', 'w')
    flag = False
    print 'Now checking file:', filename
    try:
        ET.parse(filename)
    except Exception, e:
        print 'Warning: not well-formed xml input!'
        fout.write('Warning: not well-formed xml input!\n')
        print 'Please check for:', e
        fout.write('Please check for:' + str(e) + '\n')
        flag = True

    type = sys.getfilesystemencoding()
    #check for sysid in <DOC..>

    fin = open(filename, 'rU')
    while True:
        line = fin.readline()
        if line:
            if line.startswith('<DOC'):
                match = re.search(r'<DOC docid=\".*\" sysid=\".*\">', line)
                if match:
                    break
                else:
                    print 'Warning: please check for <DOC> tag. The standard format is: <DOC docid="***" sysid="***">'
                    fout.write(
                        'Warning: please check for <DOC> tag. The standard format is: <DOC docid="***" sysid="***">\n'
                    )
                    flag = True
                    break
        else:
            break

#check whether perform substitution (& < > " ')

    while True:
        line = fin.readline()
        if line:
            match = re.search(r'<seg id=\".*\">(.*)</seg>', line)
            if match:
                strs = match.group(1)
                # if '<' in strs or '>' in strs or '\"' in strs or '\'' in strs:
                if '<' in strs or '>' in strs :
                    print 'Warning: Please check line:', line.rstrip(
                        '\n').decode("utf-8").encode(
                            type
                        ), ' did you forget to generate escape sequence?'
                    fout.write(
                        'Warning: Please check line:' +
                        line.rstrip('\n').decode("utf-8").encode(type) +
                        ' did you forget to generate escape sequence?\n')
                    flag = True
                if '&' in strs:
                    index = 0
                    index = strs.find('&', index)
                    while index != -1:
                        if strs[index:(index + 5)] != '&amp;' and strs[index:(
                                index + 4)] != '&lt;' and strs[index:(
                                    index + 4)] != '&gt;' and strs[index:(
                                        index +
                                        6)] != '&quot;' and strs[index:(
                                            index + 6)] != '&apos;':
                            print 'Warning: Please check line:', line.rstrip(
                                '\n'
                            ).decode("utf-8").encode(
                                type
                            ), ' did you forget to generate escape sequence?'
                            fout.write(
                                'Warning: Please check line:' + line.rstrip(
                                    '\n').decode("utf-8").encode(type) +
                                ' did you forget to generate escape sequence?\n'
                            )
                            flag = True
                            break
                        index += 1
                        index = strs.find('&', index)
            else:
                continue
        else:
            break

# check src and target sentence number
    finsrc = open(sys.argv[1], 'rU')
    src = finsrc.read()
    fin.seek(0)
    tst = fin.read()

    if src.count('</seg>') != tst.count('</seg>'):
        print 'Warning: Please check whether the sentence number of source and target is equal!'
        fout.write(
            'Warning: Please check whether the sentence number of source and target is equal!\n'
        )
        flag = True


#check header of target xml

    fin.seek(0)
    line = fin.readline()

    if line[:3] == codecs.BOM_UTF8:
        line = line[3:]
    else:
        pass
    #print 'Warning: You should add BOM!'
    #fout.write('Warning: You should add BOM!\n')
    #flag = True
    match = re.search(r'<(.*)>.*', line)
    if match:
        if match.group(1) != '?xml version="1.0" encoding="UTF-8"?':
            print 'Warning: Please check the first line of target file, standard format is:<?xml version="1.0" encoding="UTF-8"?>'
            fout.write(
                'Warning: Please check the first line of target file, standard format is:<?xml version="1.0" encoding="UTF-8"?>\n'
            )
            flag = True

    line = fin.readline()
    match = re.search(r'(<tstset setid=\")(.*)(\" srclang=\".*\" trglang=\".*\">)',
                      line)
    if not match:
        print 'Warning: Please check the second line of target file, standard format is:<tstset setid="***" srclang="***" trglang="***">'
        fout.write(
            'Warning: Please check the second line of target file, standard format is:<tstset setid="***" srclang="***" trglang="***">\n'
        )
        flag = True
    else:
        setid = match.group(2)
        finsrc.seek(0)
        for srcline in finsrc:
            matcher = re.search(r'(<srcset setid=\")(.*)(\" srclang=\".*\" trglang=\".*\">)',srcline)
            if matcher and match.group(2)!=setid:
                print 'Warning: Please check the second line of target file, the setid does not match srcfile'
                fout.write('Warning: Please check the second line of target file, the setid does not match srcfile\n')
        # print match.group(2)+'\n'
        # pattern = re.compile(r'(setid=")(.*?)(")')
        # matcher = re.search(pattern, line)
        # if matcher:
        #     setid = matcher.group(2)
        

    line = fin.readline()
    match = re.search(r'<system site=\".*\" sysid=\".*\">', line)
    if not match:
        print 'Warning: Please check the third line of target file, standard format is:<system site="name of participant" sysid="name of system">'
        fout.write(
            'Warning: Please check the third line of target file, standard format is:<system site="name of participant" sysid="name of system">\n'
        )
        flag = True

    if tst[:3] == codecs.BOM_UTF8:
        tst = tst[3:]
    tsts = ''
    for c in tst:
        if c != chr(10):
            tsts += c

    match = re.search(r'<system.*>(.*)</system>', tsts[:2000])
    if match:
        if len(match.group(1)) < 60:
            print 'Warning: system description info should be at least 60 bytes!'
            fout.write(
                'Warning: system description info should be at least 60 bytes!\n'
            )
            flag = True

    fin.close()
    finsrc.close()
    fout.close()
    if flag == False:
        cmd = 'del %s' % (output + '_log.txt')
        os.system(cmd)
    return flag

if __name__ == "__main__":
    global output
    if sys.argv[1] == '--help':
        print help_info
        sys.exit(0)

# fout = open('log.txt','w')
    InputData = sys.argv[2]

    curDir = ".\\"
    inputDataDir = curDir + InputData

    finalflag = False
    # get file names extented in '.xml'
    xml_list = getFileNames(inputDataDir, '.xml')
    for file in xml_list:
        fullpath = inputDataDir + file + '.xml'
        output = file
        if check(fullpath): 
            finalflag=True
    
    if finalflag:
        sys.exit(-1)
    
