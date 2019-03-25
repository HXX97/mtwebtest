package com.hit.mtweb.utils.Threads;

import java.io.*;

/**
 * 解决Process.wait()时因输入输出缓冲区太小而死锁的问题
 */
public class StreamReaderThread extends Thread {

    private InputStream is;

    public StreamReaderThread(InputStream is) {
        this.is = is;
    }

    @Override
    public void run(){
        try {
            BufferedReader bf = new BufferedReader(new InputStreamReader(is));
            String line;
            while((line = bf.readLine())!=null){
                System.out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }



}
