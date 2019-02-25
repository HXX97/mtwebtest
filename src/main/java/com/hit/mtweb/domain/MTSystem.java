package com.hit.mtweb.domain;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class MTSystem {
    private String systemid;
    private String name;
    private String software;
    private String sourcelang;
    private String targetlang;
    private String citation;
    private String website;
    private String notes;
    private boolean isConstraint;
    private boolean isPrimary;
    private String owner;

    public String getSystemid() {
        return systemid;
    }

    public String getName() {
        return name;
    }

    public String getSoftware() {
        return software;
    }

    public String getSourcelang() {
        return sourcelang;
    }

    public String getTargetlang() {
        return targetlang;
    }

    public String getCitation() {
        return citation;
    }

    public String getWebsite() {
        return website;
    }

    public String getNotes() {
        return notes;
    }

    public boolean getIsConstraint() {
        return isConstraint;
    }

    public boolean getIsPrimary() {
        return isPrimary;
    }

    public String getOwner() {
        return owner;
    }

    public void setSystemid(String systemid) {
        this.systemid = systemid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSoftware(String software) {
        this.software = software;
    }

    public void setSourcelang(String sourcelang) {
        this.sourcelang = sourcelang;
    }

    public void setTargetlang(String targetlang) {
        this.targetlang = targetlang;
    }

    public void setCitation(String citation) {
        this.citation = citation;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setIsConstraint(boolean isConstraint) {
        this.isConstraint = isConstraint;
    }

    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public String toString() {
        return "System{" +
                "systemid='" + systemid + '\'' +
                ", name='" + name + '\'' +
                ", software='" + software + '\'' +
                ", sourcelang='" + sourcelang + '\'' +
                ", targetlang='" + targetlang + '\'' +
                ", citation='" + citation + '\'' +
                ", website='" + website + '\'' +
                ", notes='" + notes + '\'' +
                ", isConstraint='" + isConstraint + '\'' +
                ", isPrimary='" + isPrimary + '\'' +
                ", owner='" + owner + '\'' +
                '}';
    }

    public static MTSystem mapToMTSystem(Map map){
        MTSystem mtSystem = new MTSystem();
        mtSystem.setSystemid(String.valueOf(map.get("systemid")));
        mtSystem.setName((String) map.get("name"));
        mtSystem.setSoftware((String) map.get("software"));
        mtSystem.setSourcelang((String) map.get("sourcelang"));
        mtSystem.setTargetlang((String) map.get("targetlang"));
        mtSystem.setCitation((String) map.get("citation"));
        mtSystem.setWebsite((String) map.get("website"));
        mtSystem.setNotes((String) map.get("notes"));
        mtSystem.setIsConstraint((Boolean) map.get("isConstraint"));
        mtSystem.setIsPrimary((Boolean)map.get("isPrimary"));
        mtSystem.setOwner((String) map.get("owner"));
        return mtSystem;
    }
}
