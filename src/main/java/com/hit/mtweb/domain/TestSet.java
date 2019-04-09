package com.hit.mtweb.domain;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class TestSet {
    private String testsetid;
    private String name;
    private String origin;
    private String domain;
    private String related_corpora;
    private String citation;
    private String notes;
    private String setups;
    private String srcurl;
    private String direction;
    private String refurl;
    private String realsrcurl;
    private String srclang;
    private String tgtlang;
    private String track;

    public static TestSet mapToTestSet(Map map) {
        TestSet testSet = new TestSet();
        testSet.setTestsetid(String.valueOf(map.get("testsetid")));
        testSet.setName((String)map.get("name"));
        testSet.setOrigin((String)map.get("origin"));
        testSet.setDomain((String)map.get("domain"));
        testSet.setRelated_corpora((String)map.get("related_corpora"));
        testSet.setCitation((String)map.get("citation"));
        testSet.setNotes((String)map.get("notes"));
        testSet.setSetups((String)map.get("setups"));
        testSet.setSrcurl((String)map.get("srcurl"));
        testSet.setDirection((String) map.get("direction"));
        testSet.setRefurl((String)map.get("refurl"));
        testSet.setRealsrcurl((String)map.get("realsrcurl"));
        testSet.setSrclang((String) map.get("srclang"));
        testSet.setTgtlang((String) map.get("tgtlang"));
        testSet.setTrack((String)map.get("track"));
        return testSet;

    }


    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }

    public String getTestsetid() {
        return testsetid;
    }

    public void setTestsetid(String testsetid) {
        this.testsetid = testsetid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getRelated_corpora() {
        return related_corpora;
    }

    public void setRelated_corpora(String related_corpora) {
        this.related_corpora = related_corpora;
    }

    public String getCitation() {
        return citation;
    }

    public void setCitation(String citation) {
        this.citation = citation;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getSetups() {
        return setups;
    }

    public void setSetups(String setups) {
        this.setups = setups;
    }

    public String getSrcurl() {
        return srcurl;
    }

    public void setSrcurl(String srcurl) {
        this.srcurl = srcurl;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getRefurl() {
        return refurl;
    }

    public void setRefurl(String refurl) {
        this.refurl = refurl;
    }

    public String getRealsrcurl() {
        return realsrcurl;
    }

    public void setRealsrcurl(String realsrcurl) {
        this.realsrcurl = realsrcurl;
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
        return "TestSet{" +
                "testsetid='" + testsetid + '\'' +
                ", name='" + name + '\'' +
                ", origin='" + origin + '\'' +
                ", domain='" + domain + '\'' +
                ", related_corpora='" + related_corpora + '\'' +
                ", citation='" + citation + '\'' +
                ", notes='" + notes + '\'' +
                ", setups='" + setups + '\'' +
                ", srcurl='" + srcurl + '\'' +
                ", direction='" + direction + '\'' +
                ", refurl='" + refurl + '\'' +
                ", realsrcurl='" + realsrcurl + '\'' +
                ", srclang='" + srclang + '\'' +
                ", tgtlang='" + tgtlang + '\'' +
                ", track='" + track + '\'' +
                '}';
    }
}
