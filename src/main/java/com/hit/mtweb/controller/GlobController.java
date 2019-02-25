package com.hit.mtweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GlobController {

    @RequestMapping("/")
    public String getHome(){
        return "index";
    }

}
