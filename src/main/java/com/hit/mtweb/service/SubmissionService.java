package com.hit.mtweb.service;

import com.hit.mtweb.dao.*;
import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.Submission;
import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.utils.Threads.HandleSubmitThread;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class SubmissionService {

    @Autowired
    SubmissionDao submissionDao;

    @Autowired
    TestSetDao testSetDao;

    @Autowired
    LangDao langDao;

    @Autowired
    SystemDao systemDao;

    @Autowired
    TrackDao trackDao;

    @Autowired
    UserDao userDao;

    public Submission handleSubmit(String setId, String sysId, String srcLang, String tgtLang, String notes, String filename, String track,String username,String path) {
        Submission submission = new Submission();
        MTSystem system = systemDao.queryById(sysId);
        TestSet testSet = testSetDao.querySetById(setId);

        submission.setSystemid(sysId);
        submission.setSystemName(system.getName());
        submission.setTestsetid(setId);
        submission.setTestset(testSet.getName());
        submission.setSubmitter(username);

        submission.setSrclang(langDao.queryFullByAbbr(srcLang));
        submission.setTgtlang(langDao.queryFullByAbbr(tgtLang));
        submission.setNotes(notes);
        //用户上传的结果
        submission.setFile(filename);
        String affiliation = userDao.getUserByName(username).getAffiliation();
        if(affiliation==null||affiliation.equals("")) affiliation="";
        submission.setAffiliation(affiliation);
        //System.setProperty("user.timezone","GMT +08");

        /*TimeZone timeZone =TimeZone.getTimeZone("GMT+8");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        sdf.setTimeZone(timeZone);*/

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // CST(北京时间)在东8区
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+8"));
        submission.setTime(sdf.format(new Date()));
        submission.setTrack(track);
        submission.setIsConstraint(system.getIsConstraint());
        submission.setState("computing...");


        //翻译方向
        String direction = trackDao.getDirection(track);

        new HandleSubmitThread(submission,testSet,system,path,direction,submissionDao).start();

        return submission;

    }

    private String computeBLEU_SBP(String setId, String srcLang, String tgtLang, String filename,String path) {

        System.out.println("setId:"+setId);
        System.out.println("srcLang:"+srcLang);
        System.out.println("tgtLang:"+tgtLang);
        System.out.println("filename:"+filename);
        System.out.println("path:"+path);
        System.out.println("RealPath:"+System.getProperty("rootPath"));

        return "100";
    }

    public void saveSubmission(Submission submission) {
        submissionDao.saveSubmission(submission);
    }

    //计算BEER，需执行本地python代码
    private String computeBEER(String setId, String srcLang, String tgtLang, String filename) {
        return "15";
    }

    //计算TER，需执行本地python代码
    private String computeTER(String setId, String srcLang, String tgtLang, String filename) {
        return "20";
    }

    //计算BLEU，需执行本地python代码
    private String computeBLEU(String setId, String srcLang, String tgtLang, String filename) {
        return "30";
    }

    public List<Submission> queryBySysId(String systemid) {
        return submissionDao.queryBySysId(systemid);
    }

    public List<Submission> queryByTrack(String track) {
        return submissionDao.queryByTrack(track);
    }

    public List<Submission> queryByOwnerNTrack(String username, String track) {
        return submissionDao.queryByOwnerNTrack(username,track);
    }

    public List<Submission> queryByTrackSortMetric(String track, String metric) {
        return submissionDao.queryByTrackSortMetric(track,metric);
    }

    public void updateBySubmission(Submission submission) {
        submissionDao.updateSubmissionBySub(submission);
    }

}
