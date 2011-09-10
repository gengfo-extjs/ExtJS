package com.baobaotao.web.topic;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.baobaotao.domain.Topic;
import com.baobaotao.service.BbtForum;

public class ListRefinedTopicController implements Controller {
	private BbtForum bbtForum;
	
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int forumId = ServletRequestUtils.getIntParameter(request,"forumId", -1);
		List<Topic> topicList = bbtForum.findRefinedTopic(forumId);
		return new ModelAndView("listRefinedTopic","topicList",topicList);
	}
}
