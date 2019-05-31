package com.hit.mtweb.domain;

public class UploadRecord {

    private String fileName;
    private String track;
    private String time;

    public UploadRecord(String fileName, String track, String time) {
        this.fileName = fileName;
        this.track = track;
        this.time = time;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "UploadRecord{" +
                "fileName='" + fileName + '\'' +
                ", track='" + track + '\'' +
                ", time='" + time + '\'' +
                '}';
    }
}
