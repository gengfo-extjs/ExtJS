package com.baobaotao.domain;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class FullUserValidator implements Validator {

	private static final Pattern EMAIL_PATTERN = Pattern
			.compile("(?:\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,3}$)");
	public boolean supports(Class clazz) {
		return clazz.equals(FullUser.class);
	}
	public void validate(Object command, Errors errors) {
		validateStep1(command,errors);
		validateStep2(command,errors);
		validateStep3(command,errors);
	}
	
    public void validateStep1(Object command,Errors errors){
    	FullUser fullUser = (FullUser) command;
    	ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName",
				"required.username", "用户名必须填写");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password",
				"required.password", "密码不能为空");
		validateEmail(fullUser.getEmail(), errors);  	
    }	

    public void validateStep2(Object command,Errors errors){
    	ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address",
				"required.address", "地址不能为空"); 	
    }	    

    public void validateStep3(Object command,Errors errors){
    	FullUser fullUser = (FullUser) command;
    	if (fullUser.getFavorites() == null || fullUser.getFavorites().size() == 0) {
    		errors.rejectValue("favorites", "required.favorites", "至少需要选择一个爱好");
		}
	
    }
    
	private void validateEmail(String email, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email",
				"required.email", "Email不能为空");
		Matcher m = EMAIL_PATTERN.matcher(email);
		if (!m.matches()) {
			errors.rejectValue("email", "invalid.email", "Email格式非法");
		}
	}
}
