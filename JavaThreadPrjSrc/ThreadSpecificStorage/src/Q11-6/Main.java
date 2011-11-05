import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;

public class Main {
    private static final int TASKS = 10;
    public static void main(String[] args) {
        // 実行するサービス
        ExecutorService service = Executors.newFixedThreadPool(3);
        try {
            for (int t = 0; t < TASKS; t++) {
                // ログに書き込むタスク
                Runnable printTask = new Runnable() {
                    public void run() {
                        Log.println("Hello!");
                        Log.close();
                    }
                };
                // タスクの実行
                service.execute(printTask);
            }
        } finally {
            service.shutdown();
        }
    }
}
