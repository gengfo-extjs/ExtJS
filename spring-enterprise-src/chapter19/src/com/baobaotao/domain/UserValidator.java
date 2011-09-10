package com.baobaotao.domain;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class UserValidator implements Validator {

	private static final Pattern EMAIL_PATTERN = Pattern
			.compile("(?:\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,3}$)");
	public boolean supports(Class clazz) {
		return clazz.equals(User.class);
	}
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName",
				"required.username", "用户名必须填写");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password",
				"required.password", "密码不能为空");
		validateEmail(user.getEmail(), errors);
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
