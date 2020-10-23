package com.akisora.epidemic.service.impl;

import com.akisora.epidemic.beans.DailyEpidemicInfo;
import com.akisora.epidemic.beans.EpidemicInfo;
import com.akisora.epidemic.beans.ProvinceInfo;
import com.akisora.epidemic.beans.UserInfo;
import com.akisora.epidemic.mapper.EpidemicMapper;
import com.akisora.epidemic.mapper.ProvinceMapper;
import com.akisora.epidemic.service.EpidemicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class EpidemicServiceImpl implements EpidemicService {

    @Autowired
    private EpidemicMapper epidemicMapper;
    @Autowired
    private ProvinceMapper  provinceMapper;

    @Override
    public List<ProvinceInfo> saveData(DailyEpidemicInfo dailyEpidemicInfo, Integer userId) {
        //当前系统日期
        Date current = new Date();
        //提交的数据的日期
        String[] ymd = dailyEpidemicInfo.getDate().split("-");
        short year=0,month=0,day=0;
        year=Short.parseShort(ymd[0]);
        month=Short.parseShort(ymd[1]);
        day=Short.parseShort(ymd[2]);

        for (EpidemicInfo epidemicInfo : dailyEpidemicInfo.getArray()){
            //设置录入该数据的用户编号
            epidemicInfo.setUserId(userId);
            //设置数据的录入日期
            epidemicInfo.setInputDate(current);
            //设置数据对应的日期
            epidemicInfo.setDataYear(year);
            epidemicInfo.setDataMonth(month);
            epidemicInfo.setDataDay(day);
            //保存数据到数据库中
            this.epidemicMapper.saveInfo(epidemicInfo);
        }
        //查询剩余未录入数据
        List<ProvinceInfo> list = this.provinceMapper.findNoDataProvinces(year,month,day);
        return list;
    }
}
