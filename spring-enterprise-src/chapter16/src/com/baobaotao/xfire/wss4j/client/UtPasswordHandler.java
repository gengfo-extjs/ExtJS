package com.baobaotao.xfire.wss4j.client;

import java.util.HashMap;
import java.util.Map;

import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;

import org.apache.ws.security.WSPasswordCallback;

public class UtPasswordHandler implements CallbackHandler {

	private static final Map<String,String> pwMockDB = new HashMap<String,String>();
	static{
		pwMockDB.put("tom", "123456");
		pwMockDB.put("john", "123456");
	}

	public void handle(Callback[] callbacks) {
		WSPasswordCallback callback = (WSPasswordCallback) callbacks[0];
		String id = callback.getIdentifer();
		System.out.println("client-> id:"+id+"/ password:"+pwMockDB.get(id));
		callback.setPassword(pwMockDB.get(id));
	}
}
