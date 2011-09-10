package com.baobaotao.xfire.wss4j.server;

import java.util.HashMap;
import java.util.Map;

import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;

import org.apache.ws.security.WSConstants;
import org.apache.ws.security.WSPasswordCallback;
import org.apache.ws.security.WSSecurityException;

public class PasswordHandler implements CallbackHandler {
	private static final Map<String,String> pwMockDB = new HashMap<String,String>();
	static{
		pwMockDB.put("server", "serverpass");
	}
	public void handle(Callback[] callbacks) throws WSSecurityException{
		WSPasswordCallback callback = (WSPasswordCallback) callbacks[0];
		String id = callback.getIdentifer();
        callback.setPassword(pwMockDB.get(id));
	}
}
