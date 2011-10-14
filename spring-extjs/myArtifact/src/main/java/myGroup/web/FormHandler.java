package myGroup.web;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import myGroup.service.Poll;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;
import ch.ralscha.extdirectspring.bean.ExtDirectResponse;
import ch.ralscha.extdirectspring.bean.ExtDirectResponseBuilder;

@Controller
public class FormHandler {

	@Inject
	private Poll poller;

	@ExtDirectMethod(value = ExtDirectMethodType.FORM_LOAD)
	public FormBean getFormData() {

		FormBean bean = new FormBean();
		bean.setFirstName("Karl");
		bean.setLastName("Pilkington");
		bean.setTime(poller.currentTime());
		return bean;
	}

	@ExtDirectMethod(value = ExtDirectMethodType.FORM_POST)
	@ResponseBody
	@RequestMapping(value = "/handleFormSubmit", method = RequestMethod.POST)
	public ExtDirectResponse handleFormSubmit(FormBean bean, HttpServletRequest request) {
		System.out.println(bean);

		ExtDirectResponseBuilder builder = new ExtDirectResponseBuilder(request);
		return builder.build();
	}

}
