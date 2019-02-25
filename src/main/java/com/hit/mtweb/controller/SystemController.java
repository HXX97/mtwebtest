package com.hit.mtweb.controller;

import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/system")
public class SystemController {

    @Autowired
    SystemService systemService;

    //查看所有Systems
    @RequestMapping("/all")
    public ModelAndView viewAllSystems(){

        ModelAndView modelAndView = new ModelAndView("system_all");
        return modelAndView;

    }

    //查看用户系统
    @RequestMapping("/user_list")
    public ModelAndView viewUserSystems(HttpServletRequest httpServletRequest){
        String username = (String) httpServletRequest.getSession().getAttribute("username");
        List<MTSystem> systemList = systemService.queryByOwner(username);
        ModelAndView modelAndView = new ModelAndView("system_user");
        modelAndView.addObject("systemList",systemList);
        return modelAndView;
    }

    //显示新建系统表单
    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String showCreateSystemForm(){
        return "system_new";
    }

    //处理新建系统
    @RequestMapping(value="/new",method = RequestMethod.POST)
    public String processCreateSystemForm(HttpServletRequest httpServletRequest,
                                          MTSystem system,
                                          RedirectAttributes model){
        String username= (String)httpServletRequest.getSession().getAttribute("username");
        system.setOwner(username);
        if(systemService.saveNewSystem(system)){
            model.addFlashAttribute("msg","Create System succeeded");
        }else {
            model.addFlashAttribute("msg","Create System failed");
        }
        return "redirect:/system/user_list";
    }


    //查看系统详情
    @RequestMapping("/detail/{systemid}")
    public ModelAndView showDetail(@PathVariable int systemid){
        ModelAndView modelAndView = new ModelAndView("system_detail");
        return modelAndView;
    }

}
