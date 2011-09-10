package com.baobaotao.xfire.wss4j.client;

import java.lang.reflect.Proxy;
import java.net.MalformedURLException;
import java.util.Properties;

import org.apache.ws.security.handler.WSHandlerConstants;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.security.wss4j.WSS4JInHandler;
import org.codehaus.xfire.security.wss4j.WSS4JOutHandler;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.util.dom.DOMInHandler;
import org.codehaus.xfire.util.dom.DOMOutHandler;

import com.baobaotao.xfire.server.BbtForumService;

public class BbtForumServiceEnc2WayClient {
	private static XFireProxyFactory serviceFactory = new XFireProxyFactory();
	public static void main(String[] args) {
		Service serviceModel = new ObjectServiceFactory()
				.create(BbtForumService.class);

		try {
			String serviceURL = "http://localhost:8088/baobaotao/service/BbtForumServiceEnc2Way";
			BbtForumService service = (BbtForumService) serviceFactory.create(
					serviceModel, serviceURL);

			Client client = ((XFireProxy) Proxy.getInvocationHandler(service))
					.getClient();
			client.addOutHandler(new DOMOutHandler());

			// 对请求SOAP报文进行加密
			Properties properties_1 = new Properties();
			properties_1.setProperty(WSHandlerConstants.ACTION,
					WSHandlerConstants.ENCRYPT);
			properties_1.setProperty(WSHandlerConstants.ENCRYPTION_USER,
					"server");
			properties_1
					.setProperty(WSHandlerConstants.ENC_PROP_FILE,
							"com/baobaotao/xfire/wss4j/client/outsecurity_enc.properties");
			client.addOutHandler(new WSS4JOutHandler(properties_1));

			client.addInHandler(new DOMInHandler());
			// 对响应SOAP报文进行解密
			Properties properties_2 = new Properties();
			properties_2.setProperty(WSHandlerConstants.ACTION,
					WSHandlerConstants.ENCRYPT);
			properties_2
					.setProperty(WSHandlerConstants.DEC_PROP_FILE,
							"com/baobaotao/xfire/wss4j/client/insecurity_enc.properties");
			properties_2.setProperty(WSHandlerConstants.PW_CALLBACK_CLASS,
					PasswordHandler.class.getName());
			client.addInHandler(new WSS4JInHandler(properties_2));
			
			int count = service.getRefinedTopicCount(20);
			System.out.println("count:" + count);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}
}
