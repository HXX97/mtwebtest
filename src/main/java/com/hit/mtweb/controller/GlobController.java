package com.hit.mtweb.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
public class GlobController {

    @RequestMapping("/")
    public String getHome() {
        return "index";
    }

    //{filename:.+} spEL表达式，用于匹配文件名中的'.'
    @RequestMapping("/download/{datatype}/{filename:.+}")
    public ResponseEntity<byte[]> downloadFile(@PathVariable String datatype,
                                                     @PathVariable String filename,
                                                     HttpServletRequest request) throws IOException {
        //获取下载文件夹位置
        String path=request.getServletContext().getRealPath(File.separator+datatype+File.separator);
        File file = new File(path+File.separator+filename);
        HttpHeaders httpHeaders = new HttpHeaders();
        //下载显示的文件名，防止中文乱码
        String downloadFileName = new String(filename.getBytes("UTF-8"),"iso-8859-1");
        //通知浏览器以attachment(下载)方式打开图片
        httpHeaders.setContentDispositionFormData("attachment",downloadFileName);
        //application/octet-stream:二进制流数据下载(最常见的文件下载)
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),httpHeaders, HttpStatus.CREATED);


    }


}
