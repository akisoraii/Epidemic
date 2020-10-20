package com.akisora.epidemic.service.impl;

import com.akisora.epidemic.beans.ProvinceInfo;
import com.akisora.epidemic.mapper.ProvinceMapper;
import com.akisora.epidemic.service.ProvinceService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProvinceServiceImpl implements ProvinceService {

    private Logger logger = Logger.getLogger(ProvinceServiceImpl.class);

    @Autowired
    private ProvinceMapper provinceMapper;

    @Override
    public List<ProvinceInfo> findNoDataProvinces(String date) {

        short year = 0, month = 0, day = 0;
        String[] array = date.split("-");
        List<ProvinceInfo> list = null;
        if (array.length >= 3) {
            year = Short.parseShort(array[0]);
            month = Short.parseShort(array[1]);
            day = Short.parseShort(array[2]);
            logger.debug("year="+year+" year="+month+" year="+day);
            list = provinceMapper.findNoDataProvinces(year, month, day);
        }

        return list;
    }
}
