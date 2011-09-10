package com.baobaotao.service;

import com.baobaotao.domain.User;

public interface UserService {
    boolean hasMatchUser(String userName,String password);
    User findUserByUserName(String userName);
    void loginSuccess(User user);
}
