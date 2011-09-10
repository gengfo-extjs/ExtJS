package com.baobaotao.dao.jdbc;

import org.springframework.jdbc.core.JdbcTemplate;

import com.baobaotao.dao.LoginLogDao;
import com.baobaotao.domain.LoginLog;

public class LoginLogDaoImpl implements LoginLogDao {
	private JdbcTemplate jdbcTemplate;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	public void insertLoginLog(LoginLog loginLog) {
		String sqlStr = "INSERT INTO t_login_log(user_id,ip,login_datetime) "
				+ "VALUES(?,?,?)";
		Object[] args = { loginLog.getUserId(), loginLog.getIp(),
				          loginLog.getLoginDate() };
		jdbcTemplate.update(sqlStr, args);
	}
}
