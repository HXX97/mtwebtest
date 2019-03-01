package com.hit.mtweb.domain;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class Submission {
    private String submissionid;
    private String systemid;
    private String systemName;
    private String testsetid;
    private String testset;
    private String file;
    private String notes;
    private String BLEU;
    private String BLEU_cased;
    private String IGNORE_BLEU;
    private String IGNORE_BLEU_cased;
    private String IGNORE_BLEU_cased_norm;
    private String TER;
    private String BEER;
    private String charac_ter;
    private String time;
    private String srclang;
    private String tgtlang;

    public static Submission mapToSubmission(Map map) {
        Submission submission = new Submission();
        submission.setSubmissionid(String.valueOf(map.get("submissionid")));
        submission.setSystemid(String.valueOf(map.get("systemid")));
        submission.setSystemName((String) map.get("systemname"));
        submission.setTestset((String) map.get("testset"));
        submission.setFile((String) map.get("file"));
        submission.setNotes((String) map.get("notes"));
        submission.setBLEU((String) map.get("BLEU"));
        submission.setBLEU_cased((String) map.get("BLEU_cased"));
        submission.setIGNORE_BLEU((String) map.get("IGNORE_BLEU"));
        submission.setIGNORE_BLEU_cased((String) map.get("IGNORE_BLEU_cased_norm"));
        submission.setTER((String) map.get("TER"));
        submission.setBEER((String)map.get("BEER"));
        submission.setCharac_ter((String) map.get("charac_ter"));
        submission.setTime((String) map.get("time"));
        submission.setSrclang((String)map.get("srclang"));
        submission.setTgtlang((String) map.get("tgtlang"));
        submission.setTestsetid(String.valueOf(map.get("testsetid")));

        return submission;
    }

    public String getSubmissionid() {
        return submissionid;
    }

    public void setSubmissionid(String submissionid) {
        this.submissionid = submissionid;
    }

    public String getSystemid() {
        return systemid;
    }

    public void setSystemid(String systemid) {
        this.systemid = systemid;
    }

    public String getTestset() {
        return testset;
    }

    public void setTestset(String testset) {
        this.testset = testset;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getBLEU() {
        return BLEU;
    }

    public void setBLEU(String BLEU) {
        this.BLEU = BLEU;
    }

    public String getBLEU_cased() {
        return BLEU_cased;
    }

    public void setBLEU_cased(String BLEU_cased) {
        this.BLEU_cased = BLEU_cased;
    }

    public String getIGNORE_BLEU() {
        return IGNORE_BLEU;
    }

    public void setIGNORE_BLEU(String IGNORE_BLEU) {
        this.IGNORE_BLEU = IGNORE_BLEU;
    }

    public String getIGNORE_BLEU_cased() {
        return IGNORE_BLEU_cased;
    }

    public void setIGNORE_BLEU_cased(String IGNORE_BLEU_cased) {
        this.IGNORE_BLEU_cased = IGNORE_BLEU_cased;
    }

    public String getIGNORE_BLEU_cased_norm() {
        return IGNORE_BLEU_cased_norm;
    }

    public void setIGNORE_BLEU_cased_norm(String IGNORE_BLEU_cased_norm) {
        this.IGNORE_BLEU_cased_norm = IGNORE_BLEU_cased_norm;
    }

    public String getTER() {
        return TER;
    }

    public void setTER(String TER) {
        this.TER = TER;
    }

    public String getBEER() {
        return BEER;
    }

    public void setBEER(String BEER) {
        this.BEER = BEER;
    }

    public String getCharac_ter() {
        return charac_ter;
    }

    public void setCharac_ter(String charac_ter) {
        this.charac_ter = charac_ter;
    }

    public String getSrclang() {
        return srclang;
    }

    public void setSrclang(String srclang) {
        this.srclang = srclang;
    }

    public String getTgtlang() {
        return tgtlang;
    }

    public void setTgtlang(String tgtlang) {
        this.tgtlang = tgtlang;
    }


    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }


    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTestsetid() {
        return testsetid;
    }

    public void setTestsetid(String testsetid) {
        this.testsetid = testsetid;
    }

    @Override
    public String toString() {
        return "Submission{" +
                "submissionid='" + submissionid + '\'' +
                ", systemid='" + systemid + '\'' +
                ", systemName='" + systemName + '\'' +
                ", testsetid='" + testsetid + '\'' +
                ", testset='" + testset + '\'' +
                ", file='" + file + '\'' +
                ", notes='" + notes + '\'' +
                ", BLEU='" + BLEU + '\'' +
                ", BLEU_cased='" + BLEU_cased + '\'' +
                ", IGNORE_BLEU='" + IGNORE_BLEU + '\'' +
                ", IGNORE_BLEU_cased='" + IGNORE_BLEU_cased + '\'' +
                ", IGNORE_BLEU_cased_norm='" + IGNORE_BLEU_cased_norm + '\'' +
                ", TER='" + TER + '\'' +
                ", BEER='" + BEER + '\'' +
                ", charac_ter='" + charac_ter + '\'' +
                ", time='" + time + '\'' +
                ", srclang='" + srclang + '\'' +
                ", tgtlang='" + tgtlang + '\'' +
                '}';
    }
}