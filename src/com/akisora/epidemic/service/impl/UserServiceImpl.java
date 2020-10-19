package com.akisora.epidemic.service.impl;

import com.akisora.epidemic.beans.UserInfo;
import com.akisora.epidemic.mapper.UserMapper;
import com.akisora.epidemic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserInfo findByAccount(String account) {

        return userMapper.findByAccount(account);
    }
}
