package com.hit.mtweb.controller;

import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.service.SubmissionService;
import com.hit.mtweb.service.SystemService;
import com.hit.mtweb.service.TestSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class SubmissionController {

    @Autowired
    SubmissionService submissionService;

    @Autowired
    TestSetService testSetService;

    @Autowired
    SystemService systemService;

    //提交第一步：选择测试集和参评系统
    @RequestMapping(value = "/submit/frame", method = RequestMethod.GET)
    public String setSubmitFrame(HttpSession session, Model model, RedirectAttributes redirectModel) {

        String username = (String)session.getAttribute("username");
        if(username==null){
            redirectModel.addFlashAttribute("errorMsg","Session expired, please login again");
            return "redirect:/user/login";
        }

        List<TestSet> testSetList = testSetService.getAllTestSets();
        model.addAttribute("testSetList",testSetList);
        List<MTSystem> systemList = systemService.queryByOwner(username);
        model.addAttribute("systemList",systemList);

        return "submit_frame";
    }

    @RequestMapping(value = "/submit/frame",method = RequestMethod.POST)
    public String processSubmitFrame(HttpServletRequest servletRequest,RedirectAttributes model){
        model.addFlashAttribute("setId",servletRequest.getParameter("setId"));
        model.addFlashAttribute("sysId", servletRequest.getParameter("sysId"));
        model.addFlashAttribute("srcLang",servletRequest.getParameter("srcLang"));
        model.addFlashAttribute("tagLang",servletRequest.getParameter("tgtLang"));
        return "redirect:/submit/upload";
    }

    //提交第二步：上传文件
    @RequestMapping(value = "/submit/upload",method = RequestMethod.GET)
    public String showUploadFileForm() {

        return "submit_upload";
    }

    @RequestMapping(value = "/submit/upload",method = RequestMethod.POST)
    public String processUploadFile(){
        return "submit_result";
    }


    //提交第三步：返回评价结果
    @RequestMapping("/submit/result")
    public String submitResult() {
        return "submit_result";
    }


}
