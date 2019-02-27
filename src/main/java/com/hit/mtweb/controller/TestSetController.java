package com.hit.mtweb.controller;

import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.service.TestSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class TestSetController {

    @Autowired
    TestSetService testSetService;

    @RequestMapping("/test_sets/list")
    public String listTestSets(Model model) {

        List<TestSet> testSetList = testSetService.getAllTestSets();
        model.addAttribute("testSetList",testSetList);

        return "testSet_list";
    }

}
