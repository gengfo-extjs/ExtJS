package com.baobaotao.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;

import com.baobaotao.domain.FullUser;
import com.baobaotao.domain.FullUserValidator;
import com.baobaotao.service.BbtForum;

//PetAddController
public class FullUserRegisterController extends AbstractWizardFormController {
	private String cancelView;
	private String successView;
	private BbtForum bbtForum;
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
/*	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
        FullUser fullUser = new FullUser();
		List favorites = new ArrayList();
		favorites.add("computer");
		favorites.add("sport");
		fullUser.setFavorites(favorites);
		return fullUser;
	}
	
	@Override
    protected Map referenceData(HttpServletRequest request, int page) throws Exception {
		if (page == 2) {
			  return new ModelMap("param3", "paramValue3")
	            .addObject("param1", "paramValue1")
	            .addObject("param2", "paramValue2");
//			List favorites = new ArrayList();
//			favorites.add("computer");
//			favorites.add("sport");
//			favorites.add("entertainment");
//			favorites.add("literature");
//			Map model = new HashMap();
//			model.put("favorites", favorites);
//			return model;
		}
		return null;
	};*/
	@Override
	protected ModelAndView processFinish(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		FullUser fullUser = (FullUser) command;
		bbtForum.registerFullUser(fullUser);
		return new ModelAndView(getSuccessView(), "fullUser", fullUser);
	}
	@Override
	protected ModelAndView processCancel(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
		return new ModelAndView(getCancelView());
	}
	
	@Override
	protected void validatePage(Object command, Errors errors, int page, boolean finish) {
		FullUserValidator validator = (FullUserValidator)getValidator();
		if (page == 0) {
			validator.validateStep1(command, errors);
		}else if (page == 1) {
			validator.validateStep2(command, errors);
		}else if (finish) {
			validator.validate(command, errors);
		}
	}
	
	public String getCancelView() {
		return cancelView;
	}
	public void setCancelView(String cancelView) {
		this.cancelView = cancelView;
	}
	public String getSuccessView() {
		return successView;
	}
	public void setSuccessView(String successView) {
		this.successView = successView;
	}
}
