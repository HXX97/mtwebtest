package com.hit.mtweb.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class SessionInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        HttpSession session = request.getSession();
        ServletContext application = session.getServletContext();
        if(application.getAttribute(session.getId()) == null||session.getAttribute("username")==null){    //未登录
            PrintWriter out = response.getWriter();
            StringBuffer sb = new StringBuffer("<script type=\"text/javascript\" charset=\"UTF-8\">");
            sb.append("alert(\"你的账号被挤掉，或者没有登录，或者页面已经过期，请重新登录\")");
            sb.append("window.location.href='/user/login';");
            sb.append("</script>");
            out.print(sb.toString());
            out.close();
            return false;
        }else{    //已经登录
            return true;
        }

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
