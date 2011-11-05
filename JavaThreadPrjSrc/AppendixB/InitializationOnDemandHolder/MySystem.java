import java.util.Date;

public class MySystem {
    private static class Holder {
        public static MySystem instance = new MySystem();
    }
    private Date date = new Date();
    private MySystem() {
    }
    public Date getDate() {
        return date;
    }
    public static MySystem getInstance() {
        return Holder.instance;
    }
}
