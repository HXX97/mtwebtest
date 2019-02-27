package com.hit.mtweb.domain;

import org.springframework.stereotype.Component;

@Component
public class Submission {
    private String submissionid;
    private String systemid;
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
    private String srclang;
    private String tgtlang;

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

    @Override
    public String toString() {
        return "Submission{" +
                "submissionid='" + submissionid + '\'' +
                ", systemid='" + systemid + '\'' +
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
                ", srclang='" + srclang + '\'' +
                ", tgtlang='" + tgtlang + '\'' +
                '}';
    }
}
