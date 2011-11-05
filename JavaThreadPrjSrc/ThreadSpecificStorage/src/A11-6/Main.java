public class Main {
    private static final int TASKS = 10;
    public static void main(String[] args) {
        for (int t = 0; t < TASKS; t++) {
            // ログに書き込むタスク
            Runnable printTask = new Runnable() {
                public void run() {
                    Log.println("Hello!");
                    Log.close();
                }
            };
            // タスクの実行
            new Thread(printTask).start();
        }
    }
}
