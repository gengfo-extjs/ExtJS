package com.baobaotao.web.topic;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.throwaway.ThrowawayController;

import com.baobaotao.domain.Topic;
import com.baobaotao.service.BbtForum;

public class ListRefinedTopicController implements ThrowawayController {
	private int forumId;
	private BbtForum bbtForum;
	public ModelAndView execute() throws Exception {
       List<Topic> topicList = bbtForum.findRefinedTopic(forumId);
	   return new ModelAndView("refinedTopicList","topicList",topicList);
	}	
	public BbtForum getBbtForum() {
		return bbtForum;
	}
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public int getForumId() {
		return forumId;
	}
	public void setForumId(int forumId) {
		this.forumId = forumId;
	}
}
