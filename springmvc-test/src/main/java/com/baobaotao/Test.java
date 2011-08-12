package com.baobaotao;

import java.util.Enumeration;
import java.util.StringTokenizer;

import org.springframework.web.util.WebUtils;

public class Test {
	public static void main(String[] args) {
        String PARAM_TARGET = "_target";
		Enumeration paramNames = new StringTokenizer("_target1 test");
		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();
			if (paramName.startsWith(PARAM_TARGET)) {
				for (int i = 0; i < WebUtils.SUBMIT_IMAGE_SUFFIXES.length; i++) {
					String suffix = WebUtils.SUBMIT_IMAGE_SUFFIXES[i];
					if (paramName.endsWith(suffix)) {
						paramName = paramName.substring(0, paramName.length() - suffix.length());
					}
				}
				int kk = Integer.parseInt(paramName.substring(PARAM_TARGET.length()));
				System.out.println("kk:"+kk);
			}
		}

	}
}
