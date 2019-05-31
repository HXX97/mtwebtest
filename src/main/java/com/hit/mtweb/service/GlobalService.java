package com.hit.mtweb.service;

import com.hit.mtweb.dao.TestSetDao;
import com.hit.mtweb.domain.Tracks4Check;
import com.hit.mtweb.utils.Threads.StreamReaderThread;
import com.hit.mtweb.utils.zipUtil.ZipUtilities;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;

@Service
public class GlobalService {

    @Autowired
    TestSetDao testSetDao;

    public String handleUpload(File newFile,String rootPath, String track, String username) {

        boolean needCheck = false;
        for(Tracks4Check tracks4Check:Tracks4Check.values()){
            if (tracks4Check.toString().equals(track)){
                needCheck=true;
                break;
            }
        }
        //无需检查
        if(!needCheck){
            File UploadDir = new File(rootPath+"uploads/final/"+track);
            if (!UploadDir.exists()){
                UploadDir.mkdirs();
            }
            try {
                FileUtils.copyFileToDirectory(newFile,UploadDir);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "提交成功，该任务文件无需格式检查。";
        }


        String result="";
        //新建工作文件夹
        String workPath =rootPath+"/work/"+username+System.currentTimeMillis();
        File workdir = new File(workPath);
        if (!workdir.exists()){
            workdir.mkdirs();
        }

        try {

            //把check文件复制到工作文件夹下
            FileUtils.copyDirectory(new File(rootPath+"eval/check"),workdir);
            //把用户上传的文件解压到工作文件夹下的InputData文件夹中
            ZipUtilities.unZip(newFile,new File(workdir,"InputData"));

            //获取原文文件
            String srcPath = testSetDao.queryByTrack(track).getRealsrcurl();
            File srcFile = new File(rootPath+"testSets/srcs/"+srcPath);
            FileUtils.copyFileToDirectory(srcFile,workdir);

            System.out.println("Starting check program...");
            //调用Python程序进行跑分
            String[] commands = {"cmd","/C","python check.py "+srcFile.getName()+" InputData\\"};
            System.out.println(commands[2]);
            Process process = Runtime.getRuntime().exec(commands,null,workdir);
            new StreamReaderThread(process.getInputStream()).start();
            new StreamReaderThread(process.getErrorStream()).start();
            process.waitFor();
            System.out.println("check program terminated");
            int exitValue = process.exitValue();
            if(exitValue!=0){
                 //result ="Check Failure";
                 StringBuilder sb = new StringBuilder("提交失败，请检查格式: <br>");
                 File[] files = workdir.listFiles();
                 for (File file:files) {
                     if (file.getName().contains(".txt")) {
                         sb.append("<br><b>"+file.getName()+":</b><br>");
                         BufferedReader bfr = new BufferedReader(new FileReader(file));
                         String line;
                         while ((line = bfr.readLine()) != null) {
                             line=line.replace("<","&lt")
                                     .replace(">","&gt")
                                     .replace("<=","&le")
                                     .replace(">=","&ge");
                             sb.append(line+"<br><br>");
                         }
                         //关闭流
                         bfr.close();
                     }
                 }
                System.out.println(sb.toString());
                 result = sb.toString();

            }else{
                File UploadDir = new File(rootPath+"uploads/final/"+track);
                if (!UploadDir.exists()){
                    UploadDir.mkdirs();
                }
                FileUtils.copyFileToDirectory(newFile,UploadDir);
                result ="上传完毕，提交成功";
            }

            //清除工作文件夹
            FileUtils.deleteDirectory(workdir);

        } catch (IOException e) {
            e.printStackTrace();
            result="出现异常，请重新上传";
        } catch (InterruptedException e) {
            e.printStackTrace();
            result="出现异常，请重新上传";
        }catch (Exception e){
            e.printStackTrace();
            result="出现异常，请重新上传";
        }
        finally {
            if(workdir.exists()){
                try {
                    //调用Jvm垃圾回收解除占用
                    System.gc();
                    FileUtils.deleteDirectory(workdir);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return result;
        }

    }
}
