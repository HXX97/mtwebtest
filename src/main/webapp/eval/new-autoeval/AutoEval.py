#coding=utf-8
import sys
import os
import operator
import re

FLAG = False  #control splitwords:ref only splited once
FLAGS = False
FLAGREF = False

#updated 2013.5 integrate with TER and METEOR 
#token reference

__author__ = "Ji Zongcheng(jizongcheng@ict.ac.cn)"
__date__ = "2009-08-31"

check_info = '''
**************************************************************
    AutoEval for MT Evaluation, version 1.3
    Designed by Ji Zongcheng, ICT, 2009-08-31

    Please Check whether you have the following files:

    --->InputData
         |-->*ref*.xml
         |-->*src*.xml    (real src)
         |-->*primary*.xml
         |-->*.xml        (raw test set)
         |-->realSegID.txt
    --->exe
         |-->mteval_sbp.exe
         |-->SignTestBleuSBP4.exe
         |-->SignTestBleuSBP5.exe
         |-->A2B.py
**************************************************************
'''

help_info = '''
**************************************************************
    The choices of Direction for Machine Translation:
    1. zh-en-news (caseSensitive)
    2. en-zh-news
    3. en-zh-scie
    4. jp-en-pat
    5. mn-zh-dail
    6. ti-zh-gove
    7. uy-zh-news
    8. ka-zh-news
    9. ki-zh-news
    10. exit
**************************************************************
'''

def getFileNames(directory, fileExtention):
    "get list of files of particular extentions"

    fileNameList = [os.path.normcase(f) for f in os.listdir(directory)]
    fileNameList = [os.path.splitext(f)[0] for f in fileNameList
                    if os.path.splitext(f)[1] == fileExtention]
    return fileNameList

def readRealSegID(input_file):
    "read realSegID from input_file"
    try:
        fin = open(input_file, 'rU')
        realSegID_list = [(e[len(e)-1].isdigit() and [e] or [e[:len(e)-1]])[0] for e in fin]
        fin.close()
    except IOError:
        print "Please check file: " + input_file + " !"
        os.system("pause")
        sys.exit(-1)
    print realSegID_list
    return realSegID_list

def A2B_middot_ref(ref_path):
    #convert reference in en-zh direction, include A2B and mid-dot conversion
    if MT_Direction != "zh-en-news":
        cmd = "python .\\exe\\A2B.py -i %s -o %s_to_A2B -e utf-8" % (ref_path,ref_path)
        os.system(cmd)
        os.system("del %s" % ref_path)
        fin = open(ref_path+'_to_A2B', 'rU')
        fout = open(ref_path, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt
        fin.close()
        fout.close()
        os.system("del %s" % ref_path+'_to_A2B')

def extractRealTestSet(input_file, output_file):
    '''extract real test set according realSegID,
    if the MT_Direction is en-zh, get on with A2B & mid-dot exchange
    '''
    print "  -->extracting RealTestSet from " + os.path.split(input_file)[1] + "..."
    fin = open(input_file, 'rU')
    fout = open(output_file, 'w')

    # copy a new list in case of deleting the original realSegID_list
    list = []; list.extend(realSegID_list)


    for line in fin:
        if line.find("<seg id=") == -1:
            fout.write(line)
        else:
            start = line.find("\"")
            end = line.find("\">")
            segid = line[start+1:end]
            if len(list) and segid == list[0]:
                fout.write(line)
                list.remove(list[0])


    fin.close()
    fout.close()

    # if the MT_Direction is en-zh, get on with A2B & mid-dot substitution


    if MT_Direction == "en-zh-news":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "en-zh-scie":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt


    elif MT_Direction == "jp-en-pat":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "mn-zh-dail":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "ti-zh-gove":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "uy-zh-news":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "ka-zh-news":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt

    elif MT_Direction == "ki-zh-news":
        cmd = "rename %s %s_to_A2B" % (output_file, output_file)
        os.system(cmd)
        cmd = "python .\\exe\\A2B.py -i %s_to_A2B -o %s_to_mid-dot_sub -e utf-8" % (output_file, output_file)
        print "     A2B status: ",
        os.system(cmd)
        fin = open(output_file+'_to_mid-dot_sub', 'rU')
        fout = open(output_file, 'w')
        count=0
        for line in fin:
            (newline, cnt) = re.subn('•', '·', line)
            fout.write(newline)
            count += cnt


        fin.close()
        fout.close()

def splitwords(input_file):
    global FLAG
    format = ".\\exe\\splitUTF8Characters %s >%s"
    cmd = format % (input_file,input_file + '.split')
    os.system(cmd)
    if FLAG == False: #reference is splited only once
        cmd = format % (inputDataDir+ref+'.xml',inputDataDir+ref+'.xml.split')
        os.system(cmd)
        FLAG = True
def tokenization():
    global FLAGS
    format = "perl .\\exe\\token.pl %s %s"
    if FLAGS == False:
        cmd = format % (inputDataDir+ref+'.xml',inputDataDir+ref+'.xml.token')
        os.system(cmd)
        FLAGS = True
def meteor_eval(input_file,output_file):
    format1 = "java -Xmx1G -jar .\\exe\\meteor\\meteor-1.4.jar %s %s -l en -sgml >%s"
    format2 = "java -Xmx1G -jar .\\exe\\meteor\\meteor-1.4.jar %s %s -l other -sgml >%s"
    if MT_Direction == "zh-en-news":
        tokenization()
        cmd = format1 % (input_file,inputDataDir+ref+'.xml.token',output_file)
    elif MT_Direction == "en-zh-news":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "en-zh-scie":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "jp-en-pat":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "mn-zh-dail":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "ti-zh-gove":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "uy-zh-news":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "ka-zh-news":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    elif MT_Direction == "ki-zh-news":
        splitwords(input_file)
        cmd = format2 % (input_file + '.split',inputDataDir+ref+'.xml.split',output_file)
    print "  -->starting meteor evaluation for " + input_file + "..."

    exitValue = os.system(cmd)
    if exitValue!=0: exitt(-1)

def buildPlainref(ref_file,output):
    #generate plaintext reference
    format = "python .\\exe\\toplainref.py %s %s"
    global FLAGREF
    if FLAGREF == False:
        cmd = format % (ref_file,output)
        os.system(cmd)
        FLAGREF = True

def buildPlaincandi(input_file,output):
    #generate plaintext candidate translation
    format = "python .\\exe\\toplaintest.py %s %s"
    cmd = format % (input_file,output)
    os.system(cmd)

def ter_eval(input_file,output_file):
    format1 = "java -jar .\\exe\\ter\\tercom.7.25.jar -s -r %s -h %s >%s"
    format2 = "java -jar .\\exe\\ter\\tercom.7.25.jar -s -r %s -h %s >%s"

    if MT_Direction == "zh-en-news":
        buildPlainref(inputDataDir+ref+'.xml.token',ref+'.xml.token.plain')
        buildPlaincandi(input_file,input_file + '.plain')
    else:
        buildPlainref(inputDataDir+ref+'.xml.split',ref+'.xml.split.plain')
        buildPlaincandi(input_file + '.split',input_file + '.split.plain')



    if MT_Direction == "zh-en-news":
        cmd = format1 % (ref + '.xml.token.plain',input_file + '.plain', output_file)
    elif MT_Direction == "en-zh-news":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "en-zh-scie":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "jp-en-pat":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "mn-zh-dail":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "ti-zh-gove":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "uy-zh-news":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "ka-zh-news":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    elif MT_Direction == "ki-zh-news":
        cmd = format2 % (ref+'.xml.split.plain', input_file + '.split.plain', output_file)
    print "  -->starting ter evaluation for " + input_file + "..."
    exitValue = os.system(cmd)
    if(exitValue!=0): exit(-1)

def mteval_sbp(input_file, output_file):
    'method for calling mteval_sbp.exe'
    format1 = ".\\exe\\mteval_sbp -c -r %s -s %s -t %s >%s"
    format2 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format3 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format4 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format5 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format6 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format7 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format8 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"
    format9 = ".\\exe\\mteval_sbp    -r %s -s %s -t %s >%s"


    if MT_Direction == "zh-en-news":
        cmd = format1 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "en-zh-news":
        cmd = format2 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "en-zh-scie":
        cmd = format3 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "jp-en-pat":
        cmd = format4 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "mn-zh-dail":
        cmd = format5 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "ti-zh-gove":
        cmd = format6 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "uy-zh-news":
        cmd = format7 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "ka-zh-news":
        cmd = format8 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    elif MT_Direction == "ki-zh-news":
        cmd = format9 % (inputDataDir+ref+'.xml', inputDataDir+src+'.xml', input_file, output_file)
    print "  -->processing " + input_file + '...'
    exitValue = os.system(cmd)
    if exitValue!=0: exit(-1)


def extractTable_mteval_sbp(input_file, input_file1, input_file2, output_file):
    'read mteval_sbp_result file, and extract one line info for printing'

    fin = open(input_file, 'rU')
    fin_meteor = open(input_file1,'rU')
    fin_ter = open(input_file2,'rU')
    fout = open(output_file, 'a')

    # read and extract
    for i in range(8): line = fin.readline()
    # mteval_sbp failed
    if line.find('NIST=') == -1: return

    #print line
    for item in line.split():
        if item.find('NIST=') != -1: NIST = item[5:]
        if item.find('BLEU=') != -1: BLEU = item[5:]
        if item.find('BLEU_SBP=') != -1: BLEU_SBP = item[9:]
        if item.find('GTM=') != -1: GTM = item[4:]
        if item.find('mWER=') != -1: mWER = item[5:]
        if item.find('mPER=') != -1: mPER = item[5:]
        if item.find('ICT=') != -1: ICT = item[4:]

    cumulative_NIST = []
    cumulative_BLEU = []
    cumulative_BLEU_SBP = []

    for i in range(15): line = fin.readline()
    #print line
    for item in line.split(): cumulative_NIST.append(item)

    for i in range(2): line = fin.readline()
    #print line
    for item in line.split(): cumulative_BLEU.append(item)

    line = fin.readline()
    #print line
    for item in line.split(): cumulative_BLEU_SBP.append(item)

    while True:
        line = fin_meteor.readline()
        if line.startswith('Final score'):
            meteor_score = (line.split()[2])[:6]
            break

    while True:
        line = fin_ter.readline()
        if line.startswith('Total TER'):
            ter_score = (line.split()[2])[:6]
            break
    #print '/////////////////////////////////////////////////////////////'
    # print

    if MT_Direction == "zh-en-news":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[4],
                                  cumulative_BLEU[4], cumulative_BLEU[6],cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "en-zh-news":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "en-zh-scie":
        #print "en-zh-scie is scheduling the second time"
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "jp-en-pat":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "mn-zh-dail":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "ti-zh-gove":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "uy-zh-news":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "ka-zh-news":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    elif MT_Direction == "ki-zh-news":
        print >> fout, '\t'.join([input_file, cumulative_BLEU_SBP[5],
                                  cumulative_BLEU[5], cumulative_BLEU[6], cumulative_NIST[6],
                                  cumulative_NIST[7], GTM, mWER, mPER, ICT, meteor_score, ter_score])
    else:

        print "error in extract for the value of MT_Direction."
        sys.exit(-1)

    fin.close()
    fin_ter.close()
    fin_meteor.close()
    fout.close()

def sort_result(input_file, output_file):
    '''sort the result_table in descending order,
    return sorted participant's names
    '''

    fin = open(input_file, "r")
    fout = open(output_file, "w")

    table = []
    for line in fin: table.append(line.split())

    if MT_Direction == "zh-en-news":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7,8,9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU4-SBP	BLEU5   BLEU6   NIST6   NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "en-zh-news":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "en-zh-scie":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "jp-en-pat":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "mn-zh-dail":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "ti-zh-gove":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "uy-zh-news":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "ka-zh-news":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")
    elif MT_Direction == "ki-zh-news":
        table.sort(key = operator.itemgetter(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0), reverse = True)
        fout.write("participants	BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER\n")

        print "error in sort_result for the value of MT_Direction"
    for line in table: print >> fout, '\t'.join(line)

    fin.close()
    fout.close()

    # record the system in the sorted table
    table_sorted_name = []
    for line in table: table_sorted_name.append(os.path.splitext(line[0])[0])
    return table_sorted_name

def SignTestBleuSBP(table_sorted_name):
    '''method for calling SignTestBleuSBP4.exe if Direction is zh-en
                  calling SignTestBleuSBP5.exe if Direction is en-zh
                  calling SignTestBleuSBP4.exe if Direction is zh-mn
    '''
    output1 = "SignTestBleuSBP4_Out"
    output2 = "SignTestBleuSBP5_Out"
    output3 = "SignTestBleuSBP5_Out"
    output4 = "SignTestBleuSBP5_Out"
    output5 = "SignTestBleuSBP5_Out"
    output6 = "SignTestBleuSBP5_Out"
    output7 = "SignTestBleuSBP5_Out"
    output8 = "SignTestBleuSBP5_Out"
    output9 = "SignTestBleuSBP5_Out"

    format1 = ".\\exe\\SignTestBleuSBP4 -c -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format2 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format3 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format4 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format5 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format6 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format7 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format8 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"
    format9 = ".\\exe\\SignTestBleuSBP5    -b %s.xmlt -t %s.xmlt -s %s -r %s >> %s"

    if len(table_sorted_name) < 2:
        print "  There are only " + str(len(table_sorted_name)) \
              + " *primary*.xml files!\n  So you can't call SignTestBleuSBP*.exe :("
        raw_input("  Please press Enter to exit.")
        sys.exit(-1)
    else:
        print "  There are " + str(len(table_sorted_name)) + " *primary*.xml files..."

    for contrast in table_sorted_name:
        print "  -->contrast: " + contrast
        for base in table_sorted_name:
            if base != contrast:
                print "     |-->base: " + base
                if MT_Direction == "zh-en-news":
                    cmd = format1 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output1)
                elif MT_Direction == "en-zh-news":
                    cmd = format2 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output2)
                elif MT_Direction == "en-zh-scie":
                    cmd = format3 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output3)
                elif MT_Direction == "jp-en-pat":
                    cmd = format4 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output4)
                elif MT_Direction == "mn-zh-dail":
                    cmd = format5 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output5)
                elif MT_Direction == "ti-zh-gove":
                    cmd = format6 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output6)
                elif MT_Direction == "uy-zh-news":
                    cmd = format7 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output7)
                elif  MT_Direction == "ka-zh-news":
                    cmd = format8 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output8)
                elif MT_Direction == "ki-zh-news":
                    cmd = format9 % (base, contrast, inputDataDir+src+'.xml', inputDataDir+ref+'.xml', output9)
                os.system(cmd)

def extractTable_SignTestBleuSBP(table_sorted_name):
    "read SignTestBleuSBP*_Out file, and extract sign test info for printing"
    if MT_Direction == "zh-en-news":
        input = "SignTestBleuSBP4_Out"
        output = "SignTestBleuSBP4_Table"
    elif MT_Direction == "en-zh-news":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "en-zh-scie":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "jp-en-pat":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "mn-zh-dail":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "ti-zh-gove":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "uy-zh-news":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "ka-zh-news":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"
    elif MT_Direction == "ki-zh-news":
        input = "SignTestBleuSBP5_Out"
        output = "SignTestBleuSBP5_Table"

    fin = open(input, "r")
    fout = open(output, "w")

    table = []
    for contrast in table_sorted_name:
        for base in table_sorted_name:
            if base == contrast:
                table.append('—')
            else:
                for i in range(21): line = fin.readline()
                if line == "not statistically significant!\n":
                    table.append('○')
                elif line.find("statistical level:"):
                    table.append('●')
                else:
                    print "found error!!!"
                    os.system("pause")

    ##    length = len(table_sorted_name)
    ##    print length
    ##    print table

    print >> fout, '\t' + '\t'.join(table_sorted_name)
    index = 0
    for contrast in table_sorted_name:
        fout.write(contrast + '\t')
        for base in table_sorted_name:
            if base != table_sorted_name[len(table_sorted_name)-1]:
                fout.write(table[index] + '\t')
            else:
                fout.write(table[index] + '\n')
            index += 1

    fin.close()
    fout.close()

def arrangeFiles():
    "arrange the files produced during the whole process"
    os.system("del *.scr")
    if MT_Direction == "zh-en-news":
        cmd_list = ['rd /s /q OutputDatazen',
                    'mkdir OutputDatazen\\result_temp',
                    'mkdir OutputDatazen\\xmlt',
                    'mkdir OutputDatazen\\result_tables',
                    'mkdir OutputDatazen\\others',

                    'copy *.result .\\OutputDatazen\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDatazen\\result_temp',
                    'copy *.xmlt .\\OutputDatazen\\xmlt',
                    'copy *table*sorted* .\\OutputDatazen\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDatazen\\result_tables',
                    'copy *log* .\\OutputDatazen\\others',
                    'copy *.xmlt_* .\\OutputDatazen\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*','del *plain','del .\\InputData\\*.token']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "en-zh-news":
        cmd_list = ['rd /s /q OutputDataezn',
                    'mkdir OutputDataezn\\result_temp',
                    'mkdir OutputDataezn\\xmlt',
                    'mkdir OutputDataezn\\result_tables',
                    'mkdir OutputDataezn\\others',

                    'copy *.result .\\OutputDataezn\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDataezn\\result_temp',
                    'copy *.xmlt .\\OutputDataezn\\xmlt',
                    'copy *table*sorted* .\\OutputDataezn\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDataezn\\result_tables',
                    'copy *log* .\\OutputDataezn\\others',
                    'copy *.xmlt_* .\\OutputDataezn\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*','del *plain', 'del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "en-zh-scie":
        cmd_list = ['rd /s /q OutputDataezs',
                    'mkdir OutputDataezs\\result_temp',
                    'mkdir OutputDataezs\\xmlt',
                    'mkdir OutputDataezs\\result_tables',
                    'mkdir OutputDataezs\\others',

                    'copy *.result .\\OutputDataezs\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDataezs\\result_temp',
                    'copy *.xmlt .\\OutputDataezs\\xmlt',
                    'copy *table*sorted* .\\OutputDataezs\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDataezs\\result_tables',
                    'copy *log* .\\OutputDataezs\\others',
                    'copy *.xmlt_* .\\OutputDataezs\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*', 'del *plain','del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "jp-en-pat":
        cmd_list = ['rd /s /q OutputDatajzn',
                    'mkdir OutputDatajzn\\result_temp',
                    'mkdir OutputDatajzn\\xmlt',
                    'mkdir OutputDatajzn\\result_tables',
                    'mkdir OutputDatajzn\\others',

                    'copy *.result .\\OutputDatajzn\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDatajzn\\result_temp',
                    'copy *.xmlt .\\OutputDatajzn\\xmlt',
                    'copy *table*sorted* .\\OutputDatajzn\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDatajzn\\result_tables',
                    'copy *log* .\\OutputDatajzn\\others',
                    'copy *.xmlt_* .\\OutputDatajzn\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*', 'del *plain','del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "mn-zh-dail":
        cmd_list = ['rd /s /q OutputDatamzd',
                    'mkdir OutputDatamzd\\result_temp',
                    'mkdir OutputDatamzd\\xmlt',
                    'mkdir OutputDatamzd\\result_tables',
                    'mkdir OutputDatamzd\\others',

                    'copy *.result .\\OutputDatamzd\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDatamzd\\result_temp',
                    'copy *.xmlt .\\OutputDatamzd\\xmlt',
                    'copy *table*sorted* .\\OutputDatamzd\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDatamzd\\result_tables',
                    'copy *log* .\\OutputDatamzd\\others',
                    'copy *.xmlt_* .\\OutputDatamzd\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*', 'del *plain','del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "ti-zh-gove":
        cmd_list = ['rd /s /q OutputDatatzg',
                    'mkdir OutputDatatzg\\result_temp',
                    'mkdir OutputDatatzg\\xmlt',
                    'mkdir OutputDatatzg\\result_tables',
                    'mkdir OutputDatatzg\\others',

                    'copy *.result .\\OutputDatatzg\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDatatzg\\result_temp',
                    'copy *.xmlt .\\OutputDatatzg\\xmlt',
                    'copy *table*sorted* .\\OutputDatatzg\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDatatzg\\result_tables',
                    'copy *log* .\\OutputDatatzg\\others',
                    'copy *.xmlt_* .\\OutputDatatzg\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*','del *plain', 'del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "uy-zh-news":
        cmd_list = ['rd /s /q OutputData',
                    'mkdir OutputDatauzn\\result_temp',
                    'mkdir OutputDatauzn\\xmlt',
                    'mkdir OutputDatauzn\\result_tables',
                    'mkdir OutputDatauzn\\others',

                    'copy *.result .\\OutputDatauzn\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDatauzn\\result_temp',
                    'copy *.xmlt .\\OutputDatauzn\\xmlt',
                    'copy *table*sorted* .\\OutputDatauzn\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDatauzn\\result_tables',
                    'copy *log* .\\OutputDatauzn\\others',
                    'copy *.xmlt_* .\\OutputDatauzn\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*', 'del *plain','del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "ka-zh-news":
        cmd_list = ['rd /s /q OutputDataazn',
                    'mkdir OutputDataazn\\result_temp',
                    'mkdir OutputDataazn\\xmlt',
                    'mkdir OutputDataazn\\result_tables',
                    'mkdir OutputDataazn\\others',

                    'copy *.result .\\OutputDataazn\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDataazn\\result_temp',
                    'copy *.xmlt .\\OutputDataazn\\xmlt',
                    'copy *table*sorted* .\\OutputDataazn\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDataazn\\result_tables',
                    'copy *log* .\\OutputDataazn\\others',
                    'copy *.xmlt_* .\\OutputDataazn\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*','del *plain', 'del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)

    if MT_Direction == "ki-zh-news":
        cmd_list = ['rd /s /q OutputDataizn',
                    'mkdir OutputDataizn\\result_temp',
                    'mkdir OutputDataizn\\xmlt',
                    'mkdir OutputDataizn\\result_tables',
                    'mkdir OutputDataizn\\others',

                    'copy *.result .\\OutputDataizn\\result_temp',
                    'copy SignTestBleuSBP*_Out .\\OutputDataizn\\result_temp',
                    'copy *.xmlt .\\OutputDataizn\\xmlt',
                    'copy *table*sorted* .\\OutputDataizn\\result_tables',
                    'copy SignTestBleuSBP*_Table .\\OutputDataizn\\result_tables',
                    'copy *log* .\\OutputDataizn\\others',
                    'copy *.xmlt_* .\\OutputDataizn\\others',

                    'del *.result', 'del SignTestBleuSBP*_Out',
                    'del *.xmlt*', 'del *table*',
                    'del *log*', 'del *plain','del .\\InputData\\*.split']
        for cmd in cmd_list: os.system(cmd)


def wc(direction):
    if direction == "zh-en-news":
        mt_direction = "zh-en-news"
    if direction == "en-zh-news":
        mt_direction = "en-zh-news"
    if direction == "en-zh-scie":
        mt_direction = "en-zh-scie"
    if direction == "jp-en-pat":
        mt_direction = "jp-en-pat"
    if direction == "mn-zh-dail":
        mt_direction = "mn-zh-dail"
    if direction == "ti-zh-gove":
        mt_direction = "ti-zh-gove"
    if direction == "uy-zh-news":
        mt_direction = "uy-zh-news"
    if direction == "ka-zh-news":
        mt_direction = "ka-zh-news"
    if direction == "ki-zh-news":
        mt_direction = "ki-zh-news"

    return mt_direction

if __name__ == "__main__":

    MT_Direction = wc(sys.argv[1])
    InputData = sys.argv[2]

    curDir = ".\\"
    exeDir = curDir + '\\exe\\'
    inputDataDir = curDir + InputData

    # get file names extented in '.xml'
    xml_list = getFileNames(inputDataDir, '.xml')
    src = [e for e in xml_list if e.find("src") != -1][0]  # src file
    ref = [e for e in xml_list if e.find("ref") != -1][0]  # ref file

    # get file names extented in '.xmlt'
    xmlt_list = xml_list
    xmlt_list.remove(src); xmlt_list.remove(ref)

    # get file names extented in '.xml' && have the key word 'primary'
    primary_xml_list = [e for e in xml_list if (e.find("primary") != -1)]

    ##print xmlt_list
    ##print xml_list
    ##print primary_xml_list
    ##print src, ref

    print "setp 0: reading realSegID..."
    realSegID_list = readRealSegID(inputDataDir + 'realSegID.txt')

    A2B_middot_ref(inputDataDir + ref +'.xml')

    print "\nsetp 1: extracting realTestSet..."
    for e in xmlt_list: extractRealTestSet(inputDataDir+e+'.xml', e+'.xmlt')

    print "\nstep 2: starting mteval_sbp..."
    for e in xmlt_list: mteval_sbp(e+'.xmlt', e+'.result')

    print "\nstep 3: starting meteor evaluation..."
    for e in xmlt_list: meteor_eval(e+'.xmlt', e+'.meteor.result')

    print "\nstep 4: starting ter evaluation..."
    for e in xmlt_list: ter_eval(e+'.xmlt', e+'.ter.result')

    print "\nstep 5: starting extract_mteval_result..."
    for e in xml_list: extractTable_mteval_sbp(e+'.result',e+'.meteor.result', e+'.ter.result', 'result_table_all')
    for e in primary_xml_list: extractTable_mteval_sbp(e+'.result',e+'.meteor.result', e+'.ter.result', 'result_table_primary')

    print "\nstep 6: starting sort_result..."
    sort_result('result_table_all', 'result_table_all_sorted')
    table_sorted_name = sort_result('result_table_primary', 'result_table_primary_sorted')

    if len(table_sorted_name) < 2:
        print "  There are only " + str(len(table_sorted_name)) \
              + " *primary*.xml files!\n  So you can't call SignTestBleuSBP*.exe :("
    else:
        print "\nstep 7: starting SignTestBleu..."
        SignTestBleuSBP(table_sorted_name)

        print "\nstep 8: starting extractTable_SignTestBleuSBP..."
        extractTable_SignTestBleuSBP(table_sorted_name)

    print "\nstep 9: arranging files..."
    arrangeFiles()

    print "finish!"
