package com.hit.mtweb.controller;

import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.User;
import com.hit.mtweb.service.SystemService;
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

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    SystemService systemService;

    //查看所有用户
    @RequestMapping("/viewAll")
    public ModelAndView viewAllUsers() {
        System.out.println("view all users");
        List<User> list = userService.getAllUsers();
        System.out.println(list);
        ModelAndView modelAndView = new ModelAndView("old/allUsers");
        modelAndView.addObject("list", list);
        return modelAndView;
    }

    //展示登录界面，GET方法
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "login_page";
    }

    //处理登录，POST方法
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String processLogin(HttpServletRequest httpServletRequest, HttpSession session, RedirectAttributes model) {
        //System.out.println(httpServletRequest.getParameter("username"));
        String loginUser = (String) httpServletRequest.getParameter("username");
        String loginPWD = (String) httpServletRequest.getParameter("password");

        if (userService.validateUserByPWD(loginUser, loginPWD)) {
            session.setAttribute("username", httpServletRequest.getParameter("username"));
            model.addFlashAttribute("msgLevel","0");
            model.addFlashAttribute("msg", "Login succeeded");
            //设置session过期时间，单位为s，-1则表示永不过期
            //session.setMaxInactiveInterval(600);
            return "redirect:/user/status";
        } else {
            model.addFlashAttribute("msgLevel","1");
            model.addFlashAttribute("errorMsg", "Username or Password wrong");
            return "redirect:/user/login";
        }
    }

    //展示个人主页，GET方法
    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public String showUserHome(Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }


        User user = userService.getUserByName(username);
        model.addAttribute("user",user);

        List<MTSystem> systemList = systemService.queryByOwner(username);
        model.addAttribute("systemList",systemList);


        return "user_homepage";
    }


    //展示注册页面,GET方法
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String showRegisterForm(){
        return "user_register";
    }


    //处理注册过程，POST方法
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String processRegister(HttpSession session, User user, RedirectAttributes model) {

        if (userService.saveUser(user)) {
            session.setAttribute("username", user.getUsername());
            model.addFlashAttribute("msgLevel","0");
            model.addFlashAttribute("msg", "Register succeeded");

            //设置session过期时间，单位为s，-1则表示永不过期
            //session.setMaxInactiveInterval(600);

            return "redirect:/user/status";
        } else {
            model.addFlashAttribute("msgLevel","1");
            model.addFlashAttribute("errorMsg", "注册失败，请重新注册");
            return "redirect:/user/register";
        }
    }

    //用户编辑个人信息页面，GET方法
    @RequestMapping(value = "/edit/{username}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable String username, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
        String sessionUser = (String) request.getSession().getAttribute("username");
        if (sessionUser == null) {//用户登录已失效
            redirectAttributes.addFlashAttribute("errorMsg", "Session expired, please login again");
            return "redirect:/user/login";
        }else if(!sessionUser.equals(username)){
            redirectAttributes.addFlashAttribute("msgLevel","1");
            redirectAttributes.addFlashAttribute("msg","尝试修改其他用户信息,已记录");
            return "redirect:/user/status";
        }else {
            User user = userService.getUserByName(username);
            model.addAttribute("user", user);
            return "user_edit";
        }

    }

    //用户编辑个人信息页面，会话超时
    @RequestMapping("/edit")
    public String editReLogin(RedirectAttributes model){
        model.addFlashAttribute("errorMsg","Session expired, please login again");
        return "redirect:/user/login";
    }


    //用户编辑个人信息提交，POST方法
    @RequestMapping(value = "/edit/{username}", method = RequestMethod.POST)
    public String processEditForm(@PathVariable String username, HttpServletRequest httpServletRequest, RedirectAttributes model) {


        User newUserInfo = new User();
        newUserInfo.setUsername(username);
        newUserInfo.setEmail(httpServletRequest.getParameter("email"));
        newUserInfo.setAffiliation(httpServletRequest.getParameter("affiliation"));
        newUserInfo.setWeb(httpServletRequest.getParameter("web"));
        newUserInfo.setPhone(httpServletRequest.getParameter("phone"));


        if (userService.updateInfo(newUserInfo)) {
            model.addFlashAttribute("msgLevel","0");
            model.addFlashAttribute("msg", "Update profile succeeded");
        } else {
            model.addFlashAttribute("msgLevel","1");
            model.addFlashAttribute("msg", "Update profile failed");
        }
        return "redirect:/user/status";

    }

    //登出
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("username");
        session.invalidate();
        return "index";
    }

    @RequestMapping(value="/changePWD",method = RequestMethod.GET)
    public String showChangePWDForm(){
        return "user_changePWD";
    }


    @RequestMapping(value = "/changePWD",method = RequestMethod.POST)
    public String changePWD(HttpServletRequest request,RedirectAttributes model){
        String old = request.getParameter("old");
        String newP = request.getParameter("new");
        String user = (String) request.getSession().getAttribute("username");
        String msg ;
        String msgLevel;

        if(userService.validateUserByPWD(user,old)){
            if(userService.updatePWD(user,newP)){
                msg="修改成功";
                msgLevel="0";
            }else{
                msg="修改失败";
                msgLevel="1";
            }
        }else{
            msgLevel="1";
            msg="修改失败，原密码错误";

        }
        model.addFlashAttribute("msgLevel",msgLevel);
        model.addFlashAttribute("msg",msg);
        return "redirect:/user/status";

    }

}
