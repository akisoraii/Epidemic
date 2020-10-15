package com.akisora.epidemic.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/*
* 控制器,处理控制端发来的请求
*/
@Controller
@RequestMapping("/user")
public class UserController {

    public static Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping("/login")
    public String login(){
        logger.debug("login()方法被执行.......");
        return "main";
    }
}
