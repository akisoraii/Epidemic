package com.akisora.epidemic.service.impl;

import com.akisora.epidemic.beans.*;
import com.akisora.epidemic.mapper.EpidemicMapper;
import com.akisora.epidemic.mapper.ProvinceMapper;
import com.akisora.epidemic.service.EpidemicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EpidemicServiceImpl implements EpidemicService {

    @Autowired
    private EpidemicMapper epidemicMapper;
    @Autowired
    private ProvinceMapper provinceMapper;

    @Override
    public List<ProvinceInfo> saveData(DailyEpidemicInfo dailyEpidemicInfo, Integer userId) {
        //当前系统日期
        Date current = new Date();
        //提交的数据的日期
        String[] ymd = dailyEpidemicInfo.getDate().split("-");
        short year = 0, month = 0, day = 0;
        year = Short.parseShort(ymd[0]);
        month = Short.parseShort(ymd[1]);
        day = Short.parseShort(ymd[2]);

        for (EpidemicInfo epidemicInfo : dailyEpidemicInfo.getArray()) {
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
        List<ProvinceInfo> list = this.provinceMapper.findNoDataProvinces(year, month, day);
        return list;
    }

    @Override
    public List<EpidemicDetailInfo> findLastestData() {
        //查询每个省份的累计数量和当日新增数量
        //获取系统日期
        Calendar calendar = new GregorianCalendar();
        short year = 0, month = 0, day = 0;
        year = (short)calendar.get(Calendar.YEAR);
        month = (short)(calendar.get(Calendar.MONTH)+1);//注意:JAVA的月份是0-11月
        day = (short)calendar.get(Calendar.DATE);
        Map<String,Short> condition = new HashMap<>();
        condition.put("year",year);
        condition.put("month",month);
        condition.put("day",day);
        List<EpidemicDetailInfo> list =epidemicMapper.findLastestData(condition);
        return list;
    }
}
