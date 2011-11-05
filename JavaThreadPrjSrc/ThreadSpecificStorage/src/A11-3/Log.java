public class Log {
    private static final ThreadLocal<TSLog> tsLogCollection = new ThreadLocal<TSLog>();

    // ログを書く
    public static void println(String s) {
        getTSLog().println(s);
    }

    // ログを閉じる
    public static void close() {
        getTSLog().close();
    }

    // スレッド固有のログを得る
    private static TSLog getTSLog() {
        TSLog tsLog = tsLogCollection.get();

        // そのスレッドからの呼び出しがはじめてなら、新規作成して登録する
        if (tsLog == null) {
            tsLog = new TSLog(Thread.currentThread().getName() + "-log.txt");
            tsLogCollection.set(tsLog);
            startWatcher(tsLog);
        }

        return tsLog;
    }

    // スレッドの終了を待つスレッドを起動する
    private static void startWatcher(final TSLog tsLog) {
        // 終了を監視される方のスレッド
        final Thread target = Thread.currentThread();
        // targetを監視するスレッド
        final Thread watcher = new Thread() {
            public void run() {
                System.out.println("startWatcher for " + target.getName() + " BEGIN");
                try {
                    target.join();
                } catch (InterruptedException e) {
                }
                tsLog.close();
                System.out.println("startWatcher for " + target.getName() + " END");
            }
        };
        // 監視の開始
        watcher.start();
    }
}
