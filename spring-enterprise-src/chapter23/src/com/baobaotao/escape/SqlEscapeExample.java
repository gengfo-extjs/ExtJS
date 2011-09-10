package com.baobaotao.escape;

import org.apache.commons.lang.StringEscapeUtils;

public class SqlEscapeExample {
	public static void main(String[] args) {
		String userName = "1' or '1'='1";
		String password = "123456";
        userName = StringEscapeUtils.escapeSql(userName);
        password = StringEscapeUtils.escapeSql(password);
		String sql = "SELECT COUNT(userId) FROM t_user WHERE userName='"
				+ userName + "' AND password ='" + password + "'";
        System.out.println(sql);
	}
}
