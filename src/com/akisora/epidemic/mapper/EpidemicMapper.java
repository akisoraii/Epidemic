package com.akisora.epidemic.mapper;

import com.akisora.epidemic.beans.EpidemicInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EpidemicMapper {
    /**
     * 保存疫情记录数据
     * @param epidemicInfo
     * @return
     */

    @Insert(value = "INSERT INTO epidemics(province_id,data_year,data_month,data_day,affirmed, " +
            "suspected,isolated,dead,cured,user_id,input_date) " +
            "VALUES(#{provinceId},#{dataYear},#{dataMonth},#{dataDay},#{affirmed}, " +
            "#{suspected},#{isolated},#{dead},#{cured},#{userId},#{inputDate}) ")
    int saveInfo(EpidemicInfo epidemicInfo);
}