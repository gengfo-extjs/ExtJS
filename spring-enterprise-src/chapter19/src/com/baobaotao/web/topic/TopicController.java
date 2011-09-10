package com.baobaotao.web.topic;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.baobaotao.domain.Topic;
import com.baobaotao.service.BbtForum;

public class TopicController extends MultiActionController {
	private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	public ModelAndView showTopic(HttpServletRequest request,
			HttpServletResponse response) {
		int topicId = ServletRequestUtils.getIntParameter(request, "topicId",
				-1);
		Topic topic = bbtForum.getTopic(topicId);
		return new ModelAndView("showTopic", "topic", topic);
	}
	public ModelAndView deleteTopic(HttpServletRequest request,
			HttpServletResponse response) {
		int topicId = ServletRequestUtils.getIntParameter(request, "topicId",
				-1);
		bbtForum.delete(topicId);
		return new ModelAndView("success");
	}
}
