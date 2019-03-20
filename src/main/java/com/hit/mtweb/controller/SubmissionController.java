package com.hit.mtweb.controller;

import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.Submission;
import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.service.LangService;
import com.hit.mtweb.service.SubmissionService;
import com.hit.mtweb.service.SystemService;
import com.hit.mtweb.service.TestSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class SubmissionController {

    @Autowired
    SubmissionService submissionService;

    @Autowired
    TestSetService testSetService;

    @Autowired
    SystemService systemService;

    @Autowired
    LangService langService;

    //提交第一步：选择测试集和参评系统
    @RequestMapping(value = "/submit/frame", method = RequestMethod.GET)
    public String setSubmitFrame(HttpSession session, Model model, RedirectAttributes redirectModel) {

        String username = (String) session.getAttribute("username");
        if (username == null) {
            redirectModel.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }

        List<TestSet> testSetList = testSetService.getAllTestSets();
        model.addAttribute("testSetList", testSetList);
        List<MTSystem> systemList = systemService.queryByOwner(username);
        model.addAttribute("systemList", systemList);

        return "submit_frame";
    }

    @RequestMapping(value = "/submit/frame", method = RequestMethod.POST)
    public String processSubmitFrame(HttpServletRequest servletRequest, Model model) {

        String setId = servletRequest.getParameter("setId");
        String sysId = servletRequest.getParameter("sysId");
        String srcLangAbbr = servletRequest.getParameter("srcLang");
        String tgtLangAbbr = servletRequest.getParameter("tgtLang");
        String track = servletRequest.getParameter("track");


        model.addAttribute("setId",setId);
        model.addAttribute("sysId",sysId);
        model.addAttribute("setName", testSetService.querySetById(setId).getName());
        model.addAttribute("sysName", systemService.queryById(sysId).getName());
        model.addAttribute("srcLang", srcLangAbbr);
        model.addAttribute("tgtLang", tgtLangAbbr);
        model.addAttribute("srcLangFull",langService.queryFullByAbbr(srcLangAbbr));
        model.addAttribute("tgtLangFull",langService.queryFullByAbbr(tgtLangAbbr));
        model.addAttribute("track",track);


        return "submit_upload";
    }

    //提交第二步：上传文件
    @RequestMapping(value = "/submit/upload", method = RequestMethod.GET)
    public String showUploadFileForm(Model model, HttpServletRequest request) {
        /*Map<String, Object> map = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);

        String testSetName = testSetService.querySetById((String) map.get("setId")).getName();
        String systemName = systemService.queryById((String) map.get("sysId")).getName();
        String sourceLangFull = langService.queryFullByAbbr((String) map.get("srcLang"));
        String tgtLangFull = langService.queryFullByAbbr((String) map.get("tgtLang"));
        String track = (String) map.get("track");

        model.addAttribute("setName", testSetName);
        model.addAttribute("sysName", systemName);
        model.addAttribute("srcLangFull", sourceLangFull);
        model.addAttribute("tgtLangFull", tgtLangFull);
        model.addAttribute("track",track);*/

        return "submit_upload";
    }

    @RequestMapping(value = "/submit/upload", method = RequestMethod.POST)
    public String processUploadFile(@RequestPart MultipartFile uploadFile,
                                    @RequestParam String notes,
                                    HttpServletRequest request, RedirectAttributes model,Model newModel) {


        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            model.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }


        model.addFlashAttribute("setId", request.getParameter("setId"));
        model.addFlashAttribute("sysId", request.getParameter("sysId"));
        model.addFlashAttribute("srcLang", request.getParameter("srcLang"));
        model.addFlashAttribute("tgtLang", request.getParameter("tgtLang"));
        model.addFlashAttribute("track",request.getParameter("track"));

        if (uploadFile.isEmpty()) {
            model.addFlashAttribute("msgLevel","1");
            model.addFlashAttribute("msg", "File is empty, please choose a file");
            return "redirect:/submit/upload";
        }


        String path = request.getServletContext().getRealPath("/uploads/");
        String filename = uploadFile.getOriginalFilename();
        String suffix = filename.substring(filename.indexOf('.'));
        String newFileName = username + System.currentTimeMillis() + suffix;

        File filePath = new File(path, filename);
        //判断路径是否存在，不存在则创建
        if (!filePath.getParentFile().exists()) {
            filePath.getParentFile().mkdirs();
        }
        //将上传文件保存到一个目标文件当中
        try {
            uploadFile.transferTo(new File(path + File.separator + newFileName));

        } catch (IOException e) {
            e.printStackTrace();
            model.addFlashAttribute("msgLevel","1");
            model.addFlashAttribute("msg", "Something error, please upload again");
            return "redirect:/submit/upload";
        }


        model.addFlashAttribute("filename", newFileName);
        model.addFlashAttribute("notes", notes);
        model.addFlashAttribute("msgLevel","0");
        model.addFlashAttribute("msg", "Upload succeeded");



        Submission submission = submissionService.handleSubmit(request.getParameter("setId"),
                request.getParameter("sysId"),
                request.getParameter("srcLang"),
                request.getParameter("tgtLang"),
                notes,
                newFileName,
                request.getParameter("track"),
                username);

        newModel.addAttribute("submission",submission);
        newModel.addAttribute("msgLevel","0");
        newModel.addAttribute("msg","Upload Succeeded");
        return "submit_result";
       /* model.addFlashAttribute("submission",submission);

        return "redirect:/submit/result";*/
    }


    //提交第三步：返回评价结果
    @RequestMapping(value = "/submit/result")
    public String submitResult(HttpServletRequest request, Model model) {
        /*Map<String, Object> map = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);
        String setId = (String) map.get("setId");
        String sysId = (String) map.get("sysId");
        String srcLang = (String) map.get("srcLang");
        String tgtLang = (String) map.get("tgtLang");
        String notes = (String) map.get("notes");
        String filename = (String) map.get("filename");
        String track = (String) map.get("track");
        Submission submission = submissionService.handleSubmit(setId, sysId, srcLang, tgtLang, notes, filename, track);
        model.addAttribute("submission",submission);*/
        return "submit_result";
    }




    @RequestMapping(value = "/submit/history",method = RequestMethod.GET)
    public String getHistory(HttpServletRequest request,RedirectAttributes model){
        return "submit_history";
    }

    @RequestMapping("/submit/history/{username}/{track}")
    @ResponseBody
    public List<Submission> getHistoryByTrack(@PathVariable String username,@PathVariable String track){

        List<Submission> submissionList = submissionService.queryByOwnerNTrack(username,track);
        return submissionList;
    }


}
