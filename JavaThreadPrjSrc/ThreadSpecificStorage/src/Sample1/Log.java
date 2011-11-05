import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Log {
    private static PrintWriter writer = null;

    // writerフィールドの初期化
    static {
        try {
            writer = new PrintWriter(new FileWriter("log.txt"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ログを書く
    public static void println(String s) {
        writer.println(s);
    }

    // ログを閉じる
    public static void close() {
        writer.println("==== End of log ====");
        writer.close();
    }
}
