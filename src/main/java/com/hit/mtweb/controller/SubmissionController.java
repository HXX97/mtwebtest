package com.hit.mtweb.controller;

import com.hit.mtweb.service.SubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SubmissionController {

    @Autowired
    SubmissionService submissionService;

    //提交第一步：选择测试集和参评系统
    @RequestMapping("/submit/frame")
    public String setSubmitFrame(){
        return "submit_frame";
    }

    //提交第二步：上传文件
    @RequestMapping("/submit/upload")
    public String uploadFile(){
        return "submit_upload";
    }

    //提交第三步：返回评价结果
    @RequestMapping("/submit/result")
    public String submitResult(){
        return "submit_result";
    }



}
