package com.baobaotao.web.user;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import sun.awt.geom.AreaOp.AddOp;

import com.baobaotao.domain.User;
import com.baobaotao.service.BbtForum;

public class UserRegisterController extends SimpleFormController {
	private BbtForum bbtForum;
	public UserRegisterController() {
		setCommandClass(User.class);
	}
	public void setBbtForum(BbtForum bbtForum) {
		this.bbtForum = bbtForum;
	}
    @Override
    protected Map referenceData(HttpServletRequest request) throws Exception {
    	Map favoriteMap = new LinkedHashMap();
    	favoriteMap.put("1", "computer");
    	favoriteMap.put("2", "sport");
    	favoriteMap.put("3", "entertainment");
    	favoriteMap.put("4", "literature");
    	
//    	List cityList = new ArrayList();
//    	cityList.add("北京");
//    	cityList.add("上海");
//    	cityList.add("天津");
//    	cityList.add("厦门");
    	
    	Map cityMap = new LinkedHashMap();
    	cityMap.put("1", "北京");
    	cityMap.put("2", "上海");
    	cityMap.put("3", "天津");
    	cityMap.put("4", "厦门");

    	return new ModelMap()
        .addObject("favoriteMap", favoriteMap)
        .addObject("cityMap",cityMap);
//    	.addObject("cityList", cityList);	
    }
	
	@Override
	protected void onBindAndValidate(HttpServletRequest request, Object command, BindException errors) throws Exception {
		errors.rejectValue("userName", "aa.aa","bb");
	}
	
	 protected Object formBackingObject(HttpServletRequest request)
			throws Exception {
		int userId = ServletRequestUtils.getIntParameter(request, "userId",-1);
		User user = bbtForum.getUser(userId);
		user.setUserName("tom");
		List favorites = new ArrayList();
		favorites.add("1");
		favorites.add("2");
		favorites.add("3");
		user.setFavorites(favorites);
//		user.setCity("4");
		return user;
	}
	@Override
	protected ModelAndView onSubmit(Object command, BindException errors)
			throws Exception {
		User user = (User) command;
		bbtForum.registerUser(user);
		return new ModelAndView(getSuccessView(), "user", user);
	}
}
