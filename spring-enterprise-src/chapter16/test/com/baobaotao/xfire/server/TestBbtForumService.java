package com.baobaotao.xfire.server;

import org.codehaus.xfire.spring.AbstractXFireSpringTest;
import org.jdom.Document;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestBbtForumService extends AbstractXFireSpringTest {

	@Override
	protected ApplicationContext createContext() {
		return new ClassPathXmlApplicationContext(
				new String[]{"applicationContext.xml"});
	}

	public void testUsingSoapRequest() throws Throwable {
		Document response = invokeService("BbtForumService",
				"/com/baobaotao/xfire/server/request_soap.xml");
		assertNoFault(response);
		addNamespace("k", "http://www.baobaotao.com");
		assertValid("//soap:Body/k:getRefinedTopicCountResponse", response);
		assertXPathEquals("//k:getRefinedTopicCountResponse/k:out/text()", "32",response);
		printNode(response);
	}
}
