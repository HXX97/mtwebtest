#coding=utf-8
# =两边不能加空格
# noinspection PyInterpreter
import sys
import os


print('当前工作路径(调用它的路径)')
print(os.getcwd()) #获取当前工作目录路径
#print os.getcwd() #获取当前工作目录路径
#print os.path.abspath('.') #获取当前工作目录路径


filePath = sys.argv[1];
print(filePath)
with open(filePath,'r',encoding='UTF-8') as f:
    print(f.read())

print('Hello World');
print('123');

'''
def text_create(name, msg):
    desktop_path = 'D:\\'
    full_path = desktop_path + name + '.txt'
    file = open(full_path,'w')
    file.write(msg)
    file.close()
    print('Done')

text_create('hello','hello world') # 调用函数
'''