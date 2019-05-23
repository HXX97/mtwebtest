package com.hit.mtweb.utils.Threads;

import com.hit.mtweb.dao.SubmissionDao;
import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.Submission;
import com.hit.mtweb.domain.TestSet;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.Objects;

public class HandleSubmitThread extends Thread {

    private Submission submission;
    private TestSet testset;
    private MTSystem system;
    private String path;
    private String direction;
    private SubmissionDao submissionDao;

    public HandleSubmitThread(Submission submission, TestSet testset, MTSystem system, String path, String direction, SubmissionDao submissionDao) {
        this.submission = submission;
        this.testset = testset;
        this.system = system;
        this.path = path;
        this.direction = direction;
        this.submissionDao = submissionDao;
    }

    @Override
    public void run(){

        //新建工作文件夹，把评测工具、评测数据都复制到工作文件夹中
        String workDirpath = path+"work/"+system.getSystemid()+System.currentTimeMillis();
        System.out.println("workDirpath:"+workDirpath);
        File workDir = new File(workDirpath);

        try {

            if(!workDir.exists()){
                workDir.mkdirs();
            }
            FileUtils.copyDirectory(new File(path+"eval/new-autoeval"),workDir);

            //处理文件，将上传文件、src、ref整合到一个文件夹InputData下
            //新建InputData
            //String destDir = path+"eval/new-autoeval/"+system.getSystemid()+"Input"+System.currentTimeMillis();
            String destDir = workDirpath+"/InputData";
            File destDirFile = new File(destDir);
            if(!destDirFile.exists()){
                destDirFile.mkdirs();
            }
            //将ref文件复制到InputData下，调用fileutils
            FileUtils.copyDirectory(new File(path+"testSets/refs/"+testset.getRefurl()),
                    destDirFile);

            //将src文件复制到InputData下，调用fileutils
            FileUtils.copyFileToDirectory(new File(path+"testSets/srcs/"+testset.getSrcurl()),
                    destDirFile);

            //将用户上传文件复制到InputData下,调用fileutils
            FileUtils.copyFileToDirectory(new File(path+"uploads/"+submission.getFile()),
                    destDirFile);

            System.out.println("Starting python program...");
            //调用Python程序进行跑分
            String[] commands = {"cmd","/C","python AutoEval.py "+direction+" InputData\\"};
            System.out.println(commands[2]);
            Process process = Runtime.getRuntime().exec(commands,null,workDir);
            new StreamReaderThread(process.getInputStream()).start();
            new StreamReaderThread(process.getErrorStream()).start();
            process.waitFor();
            System.out.println("Python program terminated");
            int exitValue = process.exitValue();


            for(String outputdir: Objects.requireNonNull(workDir.list())){
                if(outputdir.contains("OutputData")){

                    String result = workDir.getAbsolutePath()+"/"+outputdir+"/result_tables";
                    File resultDir = new File(result);
                    if(resultDir.exists()){
                        File resultFile = new File(resultDir.getAbsolutePath()+"/result_table_all_sorted");
                        if(resultFile.exists()) {
                            BufferedReader bf = new BufferedReader(new InputStreamReader(new FileInputStream(resultFile)));
                            bf.readLine();//读取第一行
                            String line= bf.readLine();
                            String[] strArr = line.split("\\s");

                            submission.setBLEU_SBP(strArr[1]);
                            submission.setBLEU_NIST(strArr[3]);
                            submission.setNIST(strArr[5]);
                            submission.setGTM(strArr[6]);
                            submission.setMWER(strArr[7]);
                            submission.setMPER(strArr[8]);
                            submission.setICT(strArr[9]);
                            submission.setMETEOR(strArr[10]);
                            submission.setTER(strArr[11]);
                            System.out.println("得分计算完成！正在存入数据库...");
                            bf.close();
                        }
                    }
                    break;
                }
            }
            if(exitValue==0){
            //更新submission状态
            submission.setState("success");}
            else{
                submission.setState("failure");
            }
            //清除工作文件夹
            FileUtils.deleteDirectory(workDir);


        } catch (Exception e) {
            submission.setState("failure");//出现问题，更新本次状态为failure
            e.printStackTrace();
        }finally {
            //submissionDao.saveSubmission(submission);
            submissionDao.updateSubmissionBySub(submission);
            System.out.println("存入数据库完成！本次提交评测结束！");
            if(workDir.exists()){
                try {
                    //调用Jvm垃圾回收解除占用
                    System.gc();
                    FileUtils.deleteDirectory(workDir);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }


}
