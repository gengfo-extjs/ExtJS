import java.sql.Connection;
import java.sql.DatabaseMetaData;

import javax.sql.DataSource;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

public class Test {
	public static void main(String[] args) throws Throwable {
		String[] path = new String[] { "classpath:applicationContext.xml" };
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(
				path);
		DataSource ds = (DataSource) ctx.getBean("dataSource");
		Connection conn = DataSourceUtils.getConnection(ds);
		DatabaseMetaData md = conn.getMetaData();
		System.out.println(md.supportsSavepoints());
		// default 2 TRANSACTION_READ_COMMITTED = 2; in Connection.java
		System.out.println(md.getDefaultTransactionIsolation());
		System.out.println(md.getDriverVersion());
		System.out.println(md.getJDBCMajorVersion() + "."
				+ md.getJDBCMinorVersion());
	}

	@Transactional(isolation = Isolation.READ_COMMITTED, propagation = Propagation.REQUIRED, readOnly = true, timeout = 123, rollbackFor = {
			DataAccessException.class, DataAccessException.class })
	public void service() {

	}
}
