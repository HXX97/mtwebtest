package com.hit.mtweb.service;

import com.hit.mtweb.dao.LangDao;
import com.hit.mtweb.dao.SubmissionDao;
import com.hit.mtweb.dao.SystemDao;
import com.hit.mtweb.dao.TestSetDao;
import com.hit.mtweb.domain.Submission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

    public Submission handleSubmit(String setId, String sysId, String srcLang, String tgtLang, String notes, String filename) {
        Submission submission = new Submission();
        submission.setSystemid(sysId);
        submission.setSystemName(systemDao.queryById(sysId).getName());
        submission.setTestsetid(setId);
        submission.setTestset(testSetDao.querySetById(setId).getName());
        submission.setSrclang(langDao.queryFullByAbbr(srcLang));
        submission.setTgtlang(langDao.queryFullByAbbr(tgtLang));
        submission.setNotes(notes);
        submission.setFile(filename);
        submission.setTime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));

        submission.setBLEU(computeBLEU(setId,srcLang,tgtLang,filename));
        submission.setTER(computeTER(setId,srcLang,tgtLang,filename));
        submission.setBEER(computeBEER(setId,srcLang,tgtLang,filename));

        this.saveSubmission(submission);

        return submission;

    }

    private void saveSubmission(Submission submission) {
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
}
