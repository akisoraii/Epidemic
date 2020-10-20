package com.akisora.epidemic.controller;

import com.akisora.epidemic.beans.ProvinceInfo;
import com.akisora.epidemic.service.ProvinceService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/province")
public class ProvinceController {

    private Logger logger = Logger.getLogger(ProvinceController.class);

    @Autowired
    private ProvinceService provinceService;

    @GetMapping("/ajax/noDataList")
    @ResponseBody
    public List<ProvinceInfo> noDataProvinceList(String date) {
        logger.debug("date=" + date);
        List<ProvinceInfo> list = null;
        if (!StringUtils.isEmpty(date)) {
            list = this.provinceService.findNoDataProvinces(date);
            logger.debug(list);
        }
        return list;
    }
}
