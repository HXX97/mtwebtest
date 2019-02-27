package com.hit.mtweb.controller;

import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/system")
public class SystemController {

    @Autowired
    SystemService systemService;

    //查看所有Systems
    @RequestMapping("/all")
    public ModelAndView viewAllSystems() {

        ModelAndView modelAndView = new ModelAndView("system_all");
        return modelAndView;

    }

    //查看用户系统
    @RequestMapping("/user_list")
    public ModelAndView viewUserSystems(HttpServletRequest httpServletRequest) {

        ModelAndView modelAndView ;

        String username = (String) httpServletRequest.getSession().getAttribute("username");
        if (username == null) {
            modelAndView = new ModelAndView("/user/login");
            modelAndView.addObject("errorMsg", "Session expired, please login again");
            return modelAndView;
        }
        modelAndView = new ModelAndView("system_user");
        List<MTSystem> systemList = systemService.queryByOwner(username);

        modelAndView.addObject("systemList", systemList);
        return modelAndView;
    }

    //显示新建系统表单
    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String showCreateSystemForm() {
        return "system_new";
    }

    //处理新建系统
    @RequestMapping(value = "/new", method = RequestMethod.POST)
    public String processCreateSystemForm(HttpServletRequest httpServletRequest,
                                          MTSystem system,
                                          RedirectAttributes model) {
        String username = (String) httpServletRequest.getSession().getAttribute("username");
        if(username==null){
            model.addFlashAttribute("errorMsg","Session expired, please login again");
            return "redirect:/user/login";
        }

        system.setOwner(username);
        if (systemService.saveNewSystem(system)) {
            model.addFlashAttribute("msg", "Create System succeeded");
        } else {
            model.addFlashAttribute("msg", "Create System failed");
        }
        return "redirect:/system/user_list";
    }


    //查看系统详情
    @RequestMapping("/detail/{systemid}")
    public String showDetail(@PathVariable String systemid, Model model) {

        MTSystem system = systemService.queryById(systemid);
        model.addAttribute("system", system);

        ModelAndView modelAndView = new ModelAndView("system_detail");
        return "system_detail";
    }

    //删除系统
    @RequestMapping("/destroy/{systemid}")
    public String destroySystem(@PathVariable String systemid, RedirectAttributes model) {

        if (systemService.deleteById(systemid)) {
            model.addFlashAttribute("msg", "Delete Succeeded");
        } else {
            model.addFlashAttribute("msg", "Delete failed");
        }
        return "redirect:/system/user_list";
    }

    //展示编辑系统表单
    @RequestMapping(value = "/edit/{systemid}", method = RequestMethod.GET)
    public String showEditSystemForm(@PathVariable String systemid, Model model) {
        MTSystem mtSystem = systemService.queryById(systemid);
        model.addAttribute("system", mtSystem);
        return "system_edit";
    }

    //编辑系统
    @RequestMapping(value = "/edit/{systemid}", method = RequestMethod.POST)
    public String processEditSystem(@PathVariable String systemid, MTSystem mtSystem, RedirectAttributes model) {
        mtSystem.setSystemid(systemid);
        if (systemService.updateById(mtSystem)) {
            model.addFlashAttribute("msg", "Edit Succeeded");
        } else {
            model.addFlashAttribute("msg", "Edit Failed");
        }
        return "redirect:/system/user_list";
    }


}
