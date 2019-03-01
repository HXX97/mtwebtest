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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
    public String processSubmitFrame(HttpServletRequest servletRequest, RedirectAttributes model) {

        String setId = servletRequest.getParameter("setId");
        String sysId = servletRequest.getParameter("sysId");
        String srcLangAbbr = servletRequest.getParameter("srcLang");
        String tgtLangAbbr = servletRequest.getParameter("tgtLang");

        model.addFlashAttribute("setId", setId);
        model.addFlashAttribute("sysId", sysId);
        model.addFlashAttribute("srcLang", srcLangAbbr);
        model.addFlashAttribute("tgtLang", tgtLangAbbr);

        return "redirect:/submit/upload";
    }

    //提交第二步：上传文件
    @RequestMapping(value = "/submit/upload", method = RequestMethod.GET)
    public String showUploadFileForm(Model model, HttpServletRequest request) {
        Map<String, Object> map = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);

        String testSetName = testSetService.querySetById((String) map.get("setId")).getName();
        String systemName = systemService.queryById((String) map.get("sysId")).getName();
        String sourceLangFull = langService.queryFullByAbbr((String) map.get("srcLang"));
        String tgtLangFull = langService.queryFullByAbbr((String) map.get("tgtLang"));

        model.addAttribute("setName", testSetName);
        model.addAttribute("sysName", systemName);
        model.addAttribute("srcLangFull", sourceLangFull);
        model.addAttribute("tgtLangFull", tgtLangFull);

        return "submit_upload";
    }

    @RequestMapping(value = "/submit/upload", method = RequestMethod.POST)
    public String processUploadFile(@RequestPart MultipartFile uploadFile,
                                    @RequestParam String notes,
                                    HttpServletRequest request, RedirectAttributes model) {

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            model.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }

        model.addFlashAttribute("setId", request.getParameter("setId"));
        model.addFlashAttribute("sysId", request.getParameter("sysId"));
        model.addFlashAttribute("srcLang", request.getParameter("srcLang"));
        model.addFlashAttribute("tgtLang", request.getParameter("tgtLang"));

        if (uploadFile.isEmpty()) {
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
            model.addFlashAttribute("msg", "Something error, please upload again");
            return "redirect:/submit/upload";
        }

        model.addFlashAttribute("filename", newFileName);
        model.addFlashAttribute("notes", notes);
        model.addFlashAttribute("msg", "Upload succeeded");
        return "redirect:/submit/result";
    }


    //提交第三步：返回评价结果
    @RequestMapping(value = "/submit/result")
    public String submitResult(HttpServletRequest request, Model model) {
        Map<String, Object> map = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);
        String setId = (String) map.get("setId");
        String sysId = (String) map.get("sysId");
        String srcLang = (String) map.get("srcLang");
        String tgtLang = (String) map.get("tgtLang");
        String notes = (String) map.get("notes");
        String filename = (String) map.get("filename");


        Submission submission = submissionService.handleSubmit(setId, sysId, srcLang, tgtLang, notes, filename);
        model.addAttribute("submission",submission);
        return "submit_result";
    }


}
