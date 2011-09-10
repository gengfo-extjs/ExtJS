package com.baobaotao.service;

import org.acegisecurity.annotation.Secured;
import com.baobaotao.domain.Forum;
public class BbtForum {
    @Secured({"PRIV_2"})
	public void updateForum(Forum forum){
	   System.out.println("execute update Forum...");
   }
}
