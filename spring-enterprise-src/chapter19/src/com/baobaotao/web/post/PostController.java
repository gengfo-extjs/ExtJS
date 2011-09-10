package com.baobaotao.web.post;

import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.util.WebUtils;

import com.baobaotao.domain.Post;
import com.baobaotao.service.BbtForum;

public class PostController extends SimpleFormController {
	private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
/*	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws ServletException {
		binder.registerCustomEditor(byte[].class,
				new ByteArrayMultipartFileEditor());
	}*/

	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		Post post = (Post) command;
		String webRoot = WebUtils.getRealPath(request.getSession().getServletContext(),"/");
		post.getAttach().transferTo(new File(
				webRoot+"/upload/"+post.getAttach().getOriginalFilename()));
		bbtForum.savePost(post);
		return new ModelAndView("success");
	}
}
