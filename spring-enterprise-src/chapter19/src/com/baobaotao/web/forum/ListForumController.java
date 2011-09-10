package com.baobaotao.web.forum;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.baobaotao.domain.Forum;
import com.baobaotao.service.BbtForum;

public class ListForumController extends AbstractController {
    private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Forum> forumList = bbtForum.getAllForum();
		return new ModelAndView("listForum","forumList",forumList);
	}
}
