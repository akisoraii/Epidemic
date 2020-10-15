package com.akisora.epidemic.mapper;

import com.akisora.epidemic.beans.UserInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    UserInfo findByAccount(String account);
}
