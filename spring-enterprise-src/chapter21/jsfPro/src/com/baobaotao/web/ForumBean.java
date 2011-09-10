package com.baobaotao.web;
import com.baobaotao.service.BbtForum;
public class ForumBean {
	private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public String getForumDesc(){
		return bbtForum.getForumDesc();
	}
}
