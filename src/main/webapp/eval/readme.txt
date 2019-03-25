AutoEval（张昊亮同学编写）功能：

测以下评测指标：
BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER
（外汉）

注意：
1. TER指标：因为程序编码的缘故，建议在Linux下测试，更准确。
2. Meteor指标：如果能调用语言资源（如同义词等），效果会更好，目前汉英的可以调用语言资源，外到汉的没有资源可调用；
3. 测试TER和METEOR相关的程序在Windows和Linux下通用，但autoeval.py程序在Windows和Linux下有区别；
4. 2013年修改了测试程序，其中一项是：程序自动对外汉的参考译文进行了A2B转换（与待测译文的转换一致了）。

使用说明:
InputData下需要文件：
    --->InputData
         |-->*ref*.xml    (参考答案)
         |-->*src*.xml    (real src)
         |-->*primary*.xml (主系统提交结果）
         |-->*contrast*.xml        (对比系统提交结果)
         |-->realSegID.txt
(参考答案、测试集DOC标签下必须有属性sysid)

运行于windows环境下，需要预先安装perl,python
请保持原有目录结构
命令：python AutoEval.py 翻译方向 InputData\
其中翻译方向可以为：
    1. zh-en-news 
    2. en-zh-news
    3. en-zh-scie
    4. jp-zh-news
    5. mn-zh-dail
    6. ti-zh-gove
    7. uy-zh-news
    8. ka-zh-news
    9. ki-zh-news
输出结果保存在OutputData***文件夹中。包含程序运行过程的中间文件以及最后的评测结果文件。

注意：文件所在的路径的任何文件/目录名中不能有空格和中文！