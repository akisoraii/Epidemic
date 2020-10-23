package com.akisora.epidemic.service;

import com.akisora.epidemic.beans.DailyEpidemicInfo;
import com.akisora.epidemic.beans.ProvinceInfo;
import com.akisora.epidemic.beans.UserInfo;

import java.util.List;


public interface EpidemicService {
    /**
     *   保存当日疫情数据,返回还未录入的省份列表
     * @param dailyEpidemicInfo
     * @return
     */

    List<ProvinceInfo> saveData(DailyEpidemicInfo dailyEpidemicInfo, Integer userId);
}
