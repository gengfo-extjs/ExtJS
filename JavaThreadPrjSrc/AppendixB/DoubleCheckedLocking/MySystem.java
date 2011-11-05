// ×正しく動作することは保証されない
import java.util.Date;

public class MySystem {
    private static MySystem instance = null;
    private Date date = new Date();
    private MySystem() {
    }
    public Date getDate() {
        return date;
    }
    public static MySystem getInstance() {
        if (instance == null) {                 // (a) 1回目のtest
            synchronized (MySystem.class) {     // (b) synchronizedブロックに入る
                if (instance == null) {         // (c) 2回目のtest
                    instance = new MySystem();  // (d) set
                }
            }                                   // (e) synchronizedブロックから出る
        }
        return instance;                        // (f)
    }
}
