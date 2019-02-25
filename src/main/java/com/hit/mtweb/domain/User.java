package com.hit.mtweb.domain;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class User {
    private String username;
    private String email;
    private String affiliation;
    private String web;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAffiliation() {
        return affiliation;
    }

    public void setAffiliation(String affiliation) {
        this.affiliation = affiliation;
    }

    public String getWeb() {
        return web;
    }

    public void setWeb(String web) {
        this.web = web;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", affiliation='" + affiliation + '\'' +
                ", web='" + web + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public static User mapToUser(Map map){
        User user = new User();
        user.setUsername((String)map.get("username"));
        user.setPassword((String)map.get("password"));
        user.setAffiliation((String)map.get("affiliation"));
        user.setEmail((String)map.get("email"));
        user.setWeb((String)map.get("web"));
        return user;
    }
}
