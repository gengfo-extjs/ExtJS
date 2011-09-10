package com.baobaotao.xfire.wss4j.client;

import java.lang.reflect.Proxy;
import java.net.MalformedURLException;
import java.util.Properties;

import org.apache.ws.security.WSConstants;
import org.apache.ws.security.handler.WSHandlerConstants;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.security.wss4j.WSS4JOutHandler;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.util.dom.DOMOutHandler;

import com.baobaotao.xfire.server.BbtForumService;

public class BbtForumServiceUTClient {
	private static XFireProxyFactory serviceFactory = new XFireProxyFactory();
	public static void main(String[] args) {
		Service serviceModel = new ObjectServiceFactory().create(BbtForumService.class);
		
		try {
			String serviceURL = "http://localhost:8088/baobaotao/service/BbtForumServiceUT";
			BbtForumService service =  (BbtForumService) serviceFactory.create(serviceModel, serviceURL);

			Client client = ((XFireProxy)Proxy.getInvocationHandler(service)).getClient();
			client.addOutHandler(new DOMOutHandler());
			
			Properties properties = new Properties();
			properties.setProperty(WSHandlerConstants.ACTION, WSHandlerConstants.USERNAME_TOKEN);
			properties.setProperty(WSHandlerConstants.PASSWORD_TYPE, WSConstants.PW_DIGEST);
			properties.setProperty(WSHandlerConstants.USER, "tom");
			properties.setProperty(WSHandlerConstants.PW_CALLBACK_CLASS, UtPasswordHandler.class.getName());
			client.addOutHandler(new WSS4JOutHandler(properties));
			
			int count = service.getRefinedTopicCount(20);
		    System.out.println("count:"+count);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}
}
