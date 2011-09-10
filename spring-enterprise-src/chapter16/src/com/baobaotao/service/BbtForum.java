package com.baobaotao.service;

import javax.jws.WebService;

import com.baobaotao.xfire.server.BbtForumService;

@WebService(serviceName = "BbtForumService",endpointInterface = "com.baobaotao.xfire.server.BbtForumService")
public class BbtForum implements BbtForumService{
	public int getForumCount() {
		return 10;
	}  
	public int getRefinedTopicCount(int lastDay) {
		if(lastDay <= 2) return 10;
		else if(lastDay <= 5) return 20;
		else return 32;
	} 
}
