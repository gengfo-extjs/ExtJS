package com.baobaotao.web.forum;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;

import com.baobaotao.domain.Topic;
import com.baobaotao.service.BbtForum;

public class RefinedTopicController extends AbstractCommandController {
    private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}	
	public RefinedTopicController(){
		setCommandClass(RefinedTopicQuery.class);
	}
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
	}	
	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		RefinedTopicQuery rtq = (RefinedTopicQuery)command;
		List<Topic> topicList = bbtForum.findRefinedTopic(rtq);
		System.out.println(rtq.getBeginDate());
		return new ModelAndView("definedTopicList","topicList",topicList);
	}
}
