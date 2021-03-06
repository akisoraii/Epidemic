package com.akisora.epidemic.controller;

import com.akisora.epidemic.beans.UserInfo;
import com.akisora.epidemic.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;


/*
* 控制器,处理控制端发来的请求
*/
@Controller
@RequestMapping("/user")
public class UserController {

    public static Logger logger = Logger.getLogger(UserController.class);
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(UserInfo userInfo, Model model, HttpSession session){
        //通过该业务逻辑层的bean获取该账号对应的用户信息
        UserInfo user = this.userService.findByAccount(userInfo.getAccount());
        if (user==null){
            //账号不正确
            model.addAttribute("msg","账号不正确!");
            return "login";
        }
        if (user.getPassword().equals(userInfo.getPassword())){
            //登录成功 重定向
            //将当前用户的信息保存到Session中
            session.setAttribute("loginUser",user);
            return "redirect:/main.jsp";
        }
        //密码不正确
        model.addAttribute("msg","密码不正确!");
        return "login";
    }

    //退出登录
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        //清空Session
        session.invalidate();
        //返回epidemic页面
        return "redirect:/epidemic.jsp";
    }
}
