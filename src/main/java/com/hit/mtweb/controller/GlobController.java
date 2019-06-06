package com.hit.mtweb.controller;

import com.hit.mtweb.domain.Submission;
import com.hit.mtweb.domain.UploadRecord;
import com.hit.mtweb.service.GlobalService;
import com.hit.mtweb.service.SubmissionService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.logging.Logger;

@Controller
public class GlobController {


    @Autowired
    SubmissionService submissionService;

    @Autowired
    GlobalService globalService;

    //Logger logger = Logger.getLogger(String.valueOf(GlobController.class));

    @RequestMapping("/")
    public String getHome(Model model) {
        //logger.info("Visited Homepage");

        return "index";
    }

    @RequestMapping("/board")
    public String getBoard() {
        return "leaderBoard";
    }


    @RequestMapping("/test")
    public String getTest() {
        return "test";
    }

    @RequestMapping("/about")
    public String getAbout() {
        return "about";
    }

    //{filename:.+} spEL表达式，用于匹配文件名中的'.'
    @RequestMapping("/download/{datatype}/{filename:.+}")
    public ResponseEntity<byte[]> downloadFile(@PathVariable String datatype,
                                               @PathVariable String filename,
                                               HttpServletRequest request) throws IOException {
        //获取下载文件夹位置
        String path = request.getServletContext().getRealPath(File.separator + datatype + File.separator);
        if (datatype.equals("testSets")) {
            path += File.separator + "srcs" + File.separator;
        }
        File file = new File(path + File.separator + filename);
        if(!file.exists()){
            filename="error.xml";
            file = new File(request.getServletContext().getRealPath("/uploads/error.xml"));
        }

        HttpHeaders httpHeaders = new HttpHeaders();
        //下载显示的文件名，防止中文乱码
        String downloadFileName = new String(filename.getBytes("UTF-8"), "iso-8859-1");
        //通知浏览器以attachment(下载)方式打开图片
        httpHeaders.setContentDispositionFormData("attachment", downloadFileName);
        //application/octet-stream:二进制流数据下载(最常见的文件下载)
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), httpHeaders, HttpStatus.CREATED);

    }

    @RequestMapping("/leaderboard/{track}/{metric}")
    @ResponseBody
    public List<Submission> getLeaderBoard(@PathVariable String track, @PathVariable String metric) {

        //List<Submission> list = submissionService.queryByTrack(track);
        List<Submission> list = submissionService.queryByTrackSortMetric(track, metric);
        return list;

    }


    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String showUploadFileForm(HttpServletRequest request,
                                     RedirectAttributes model,
                                     Model newModel) {

        //若会话超时，重定向到登录页面
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            model.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }

        List<UploadRecord> recordList = new LinkedList<>();
        LinkedList<File> dirList = new LinkedList<>();
        File uploadDir = new File(request.getServletContext().getRealPath("/uploads/final"));
        if (uploadDir.exists()) {
            dirList.add(uploadDir);
        }
        while (!dirList.isEmpty()) {
            File curDir = dirList.pop();
            if (curDir.isDirectory()) {//是文件夹，则把该文件夹下所有文件加入搜索队列
                for (File file : Objects.requireNonNull(curDir.listFiles())) {
                    dirList.addLast(file);
                }
            }else if (curDir.getName().contains(username)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                recordList.add(new UploadRecord(curDir.getName(),
                        curDir.getParentFile().getName(),
                        sdf.format(new Date(curDir.lastModified()))));
            }
        }


        newModel.addAttribute("recordList", recordList);


        return "finalUpload";
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String processUpload(@RequestPart MultipartFile uploadFile,
                                @RequestParam String track,
                                HttpServletRequest request,
                                RedirectAttributes model,
                                Model newModel) {

        //上传结果
        String uploadResult = "上传失败";
        String msgLevel = "1";


        //若会话超时，重定向到登录页面
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            model.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }


        //检查该用户是否上传过,上传过禁止用户再次上传
        File uploadDir = new File(request.getServletContext().getRealPath("/uploads/final/" + track));
        if (uploadDir.exists()) {
            File[] files = uploadDir.listFiles();
            for (File file : files) {
                if (file.getName().contains(username)) {
                    msgLevel = "1";
                    uploadResult = "单个任务只能成功提交一次。该任务您已提交，请勿重复提交。";
                    newModel.addAttribute("msgLevel", msgLevel);
                    newModel.addAttribute("uploadResult", uploadResult);
                    return "finalUpload_result";
                }
            }
        }

        //上传文件为空，让用户重新上传
        if (uploadFile.isEmpty()) {
            model.addFlashAttribute("msgLevel", "1");
            model.addFlashAttribute("msg", "File is empty, please choose a file");
            return "redirect:/upload";
        }

        //开始上传处理
        //上传文件夹
        String path = request.getServletContext().getRealPath("/uploads/tmp");
        //String filename = uploadFile.getOriginalFilename();
        //新文件名
        String newFileName = username + "_" + track + ".zip";

        File newFile = new File(path, newFileName);
        //判断路径是否存在，不存在则创建
        if (!newFile.getParentFile().exists()) {
            newFile.getParentFile().mkdirs();
        }
        //判断文件是否已存在,已存在则删除
        if (newFile.exists()) {
            newFile.delete();
        }


        //将上传文件保存到一个目标文件当中
        try {
            uploadFile.transferTo(newFile);

        } catch (IOException e) {
            e.printStackTrace();
            model.addFlashAttribute("msgLevel", "1");
            model.addFlashAttribute("msg", "Something error, please upload again");
            return "redirect:/submit/upload";
        }


        String rootPath = request.getServletContext().getRealPath("/");

        uploadResult = globalService.handleUpload(newFile, rootPath, track, username);
        if (uploadResult.contains("成功")) {
            msgLevel = "0";
        } else {
            msgLevel = "1";
        }

        newModel.addAttribute("uploadResult", uploadResult);
        newModel.addAttribute("msgLevel", msgLevel);


        return "finalUpload_result";
    }


    @RequestMapping(value = "/upload/history", method = RequestMethod.GET)
    public String uploadHistory() {
        return "finalUpload_history";
    }


}
