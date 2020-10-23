package com.akisora.epidemic.controller;


import com.akisora.epidemic.beans.AjaxResponseInfo;
import com.akisora.epidemic.beans.DailyEpidemicInfo;
import com.akisora.epidemic.beans.ProvinceInfo;
import com.akisora.epidemic.beans.UserInfo;
import com.akisora.epidemic.service.EpidemicService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/epidemicData")
public class EpidemicController {

    private Logger logger = Logger.getLogger(EpidemicController.class);

    @Autowired
    private EpidemicService epidemicService;


    @PostMapping("/ajax/input")
    @ResponseBody    //应答体:将客户端发来的内容经以下方法处理后返回json格式给客户端
//    @RequestBody   请求体:将客户端发来的json数据内容解析成java类对象进行存储
    public AjaxResponseInfo inputData(@RequestBody DailyEpidemicInfo dailyEpidemicInfo, HttpSession session) {
        //创建响应信息对象
        AjaxResponseInfo responseInfo = new AjaxResponseInfo();
        //从Session中取得当前登录系统的用户信息
        UserInfo user = (UserInfo) session.getAttribute("loginUser");
        if (user == null) {
            responseInfo.setCode(-2);
            responseInfo.setMsg("请登录后再操作!");
        } else {
            //数据发送到业务层处理
            List<ProvinceInfo> list = this.epidemicService.saveData(dailyEpidemicInfo, user.getUserId());
            //接受业务层返回信息,返回json格式给客户端
            responseInfo.setData(list);
        }
        return responseInfo;
    }
}
