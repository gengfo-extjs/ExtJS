package com.baobaotao.service;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService(serviceName = "BbtForumWebService",targetNamespace = "http://service.baobaotao.com")
public interface BbtForumWebService {
	@WebMethod
	int getForumCount();
}
