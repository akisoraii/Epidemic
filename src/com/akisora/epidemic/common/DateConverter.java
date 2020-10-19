package com.akisora.epidemic.common;

import org.apache.log4j.Logger;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 数据转换器
 */
//通用组件
@Component
public class DateConverter implements Converter<String, Date> {
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public static Logger logger = Logger.getLogger(DateConverter.class);

    @Override
    public Date convert(String s) {
        if (s == null || s.length() == 0) {
            return null;
        }
        Date date = null;

        try {
            date = sdf.parse(s);
        } catch (ParseException e) {
            logger.error("装换提交的参数 " + s + "为日期值时出错\t" + e.getMessage());
        }
        return date;
    }
}
