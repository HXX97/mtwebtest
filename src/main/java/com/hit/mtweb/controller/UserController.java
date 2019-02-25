package com.hit.mtweb.controller;

import com.hit.mtweb.domain.User;
import com.hit.mtweb.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    UserService userService;

    //查看所有用户
    @RequestMapping("/viewAll")
    public ModelAndView viewAllUsers(){
        System.out.println("view all users");
        List<User> list = userService.getAllUsers();
        System.out.println(list);
        ModelAndView modelAndView = new ModelAndView("allUsers");
        modelAndView.addObject("list",list);
        return modelAndView;
    }

    //展示登录界面，GET方法
    @RequestMapping(value="/login",method = RequestMethod.GET)
    public String showLoginForm(){
        return "login_page";
    }

    //处理登录，POST方法
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String processLogin(HttpServletRequest httpServletRequest, HttpSession session, RedirectAttributes model){
        //System.out.println(httpServletRequest.getParameter("username"));
        String loginUser = (String) httpServletRequest.getParameter("username");
        String loginPWD = (String) httpServletRequest.getParameter("password");

        if(userService.validateUserByPWD(loginUser,loginPWD)) {
            session.setAttribute("username", httpServletRequest.getParameter("username"));
            model.addFlashAttribute("msg","Login succeeded");
            return "redirect:/user/status";
        }else{
            model.addFlashAttribute("errorMsg","Username or Password wrong");
            return "redirect:/user/login";
        }
    }

    //展示个人主页，GET方法
    @RequestMapping(value="/status",method = RequestMethod.GET)
    public String showUserHome(HttpSession session,Model model){
        /*String username = (String) session.getAttribute("username");
        model.addAttribute("username",username);*/
        return "user_homepage";
    }

    //处理注册过程，POST方法
    @RequestMapping(value="/register",method = RequestMethod.POST)
    public String processRegister(HttpSession session,User user,RedirectAttributes model){

        if(userService.saveUser(user)){
            session.setAttribute("username", user.getUsername());
            model.addFlashAttribute("msg","Register succeeded");
            return "redirect:/user/status";
        }else{
            model.addFlashAttribute("errorMsg","注册失败，请重新注册");
            return "redirect:/user/login";
        }
    }

    //用户编辑个人信息页面，GET方法
    @RequestMapping(value="/edit/{username}",method = RequestMethod.GET)
    public String showEditForm(@PathVariable String username,Model model){
        User user = userService.getUserByName(username);
        model.addAttribute("user",user);
        return "user_edit";
    }


    //用户编辑个人信息提交，POST方法
    @RequestMapping(value="/edit/{username}",method = RequestMethod.POST)
    public String processEditForm(@PathVariable String username,HttpServletRequest httpServletRequest,RedirectAttributes model){

        User newUserInfo = new User();
        newUserInfo.setUsername(username);
        newUserInfo.setEmail(httpServletRequest.getParameter("email"));
        newUserInfo.setAffiliation(httpServletRequest.getParameter("affiliation"));
        newUserInfo.setWeb(httpServletRequest.getParameter("web"));


        if(userService.updateInfo(newUserInfo)){
            model.addFlashAttribute("msg","Update profile succeeded");
        }else{
            model.addFlashAttribute("msg","Update profile failed");
        }
        return "redirect:/user/status";

    }

    //登出
    @RequestMapping(value="/logout")
    public String logout(HttpSession session){
        session.removeAttribute("username");
        return "index";
    }

}
