package com.akisora.epidemic.service;

import com.akisora.epidemic.beans.UserInfo;

public interface UserService {

    /**
     * 根据用户的账号获取用户信息
     *
     * @param account 账号
     * @return 用户信息
     */
    UserInfo findByAccount(String account);
}
