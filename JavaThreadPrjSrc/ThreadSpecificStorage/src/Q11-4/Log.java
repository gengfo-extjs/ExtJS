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
        }

        return tsLog;
    }
}
