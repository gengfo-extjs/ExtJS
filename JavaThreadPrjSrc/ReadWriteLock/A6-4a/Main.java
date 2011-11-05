public class Main {
    public static void main(String[] args) {
        Database<String,String> database  = new Database<String,String>();

        // AssignThreadスレッドの起動
        new AssignThread(database, "Alice", "Alaska").start();
        new AssignThread(database, "Alice", "Australia").start();
        new AssignThread(database, "Bobby", "Brazil").start();
        new AssignThread(database, "Bobby", "Bulgaria").start();

        // RetrieveThreadスレッドの起動
        for (int i = 0; i < 100; i++) {
            new RetrieveThread(database, "Alice").start();
            new RetrieveThread(database, "Bobby").start();
        }

        // 約10秒間停止
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
        }

        // 強制終了
        System.exit(0);
    }
}
