package com.baobaotao.service;

import com.baobaotao.domain.User;

public class MailService {
   public void sendMail(User user){
	   System.out.println("ths user is:"+user.getUserName());
	   System.out.println("send mail to "+user.getEmail());
   }
}
