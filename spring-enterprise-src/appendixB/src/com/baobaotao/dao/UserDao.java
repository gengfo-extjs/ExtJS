package com.baobaotao.dao;

import com.baobaotao.domain.User;

public interface UserDao {
   int getMatchCount(String userName,String password);
   User findUserByUserName(String userName);
   void updateLoginInfo(User user);
}
