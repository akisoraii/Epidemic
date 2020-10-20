package com.akisora.epidemic.service;

import com.akisora.epidemic.beans.ProvinceInfo;

import java.util.List;

public interface ProvinceService {

    /**
     * 获取还未录入数据的省份列表
     *
     */
    List<ProvinceInfo> findNoDataProvinces(String date);
}
