import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.IOException;

public class TSLog {
    private PrintWriter writer = null;

    // writerフィールドの初期化
    public TSLog(String filename) {
        try {
            writer = new PrintWriter(new FileWriter(filename));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ログを書く
    public void println(String s) {
        writer.println(s);
    }

    // ログを閉じる
    public void close() {
        writer.println("==== End of log ====");
        writer.close();
    }
}
