import java.sql.Connection;
import java.sql.Statement;
public class TopicDao {
	private static ThreadLocal<Connection> connThreadLocal = new ThreadLocal<Connection>();
	public static Connection getConnection(){
		if (connThreadLocal.get() == null) {
			Connection conn = null;
			connThreadLocal.set(conn);
            return conn;
		}else{
			return connThreadLocal.get();
		}
	}
	public void addTopic() {
		Statement stat = getConnection().createStatement();
	}
}
