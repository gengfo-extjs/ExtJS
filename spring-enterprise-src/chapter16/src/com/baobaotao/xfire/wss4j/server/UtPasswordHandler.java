package com.baobaotao.xfire.wss4j.server;

import java.util.HashMap;
import java.util.Map;

import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;

import org.apache.ws.security.WSConstants;
import org.apache.ws.security.WSPasswordCallback;
import org.apache.ws.security.WSSecurityException;

public class UtPasswordHandler implements CallbackHandler {
	private static final Map pwMockDB = new HashMap();
	static{
		pwMockDB.put("tom", "123456");
		pwMockDB.put("john", "123456");
		pwMockDB.put("katty", "123456");
		pwMockDB.put("mike", "123456");
	}
	
	public void handle(Callback[] callbacks) throws WSSecurityException{
		WSPasswordCallback callback = (WSPasswordCallback) callbacks[0];
		String id = callback.getIdentifer();
		String validPw = (String)pwMockDB.get(id);
		if(WSConstants.PASSWORD_TEXT.equals(callback.getPasswordType())){		
			String pw = callback.getPassword();
			if(pw == null || !pw.equalsIgnoreCase(validPw)){
				throw new WSSecurityException("password not match");
			}
		}
		else{
			callback.setPassword(validPw);
		}
	}
}
