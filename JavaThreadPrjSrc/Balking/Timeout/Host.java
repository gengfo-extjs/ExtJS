import java.util.concurrent.TimeoutException;

public class Host {
    private final long timeout; // タイムアウト値
    private boolean ready = false; // メソッド実行してよいならtrue

    public Host(long timeout) {
        this.timeout = timeout;
    }

    // 状態の変更をする
    public synchronized void setExecutable(boolean on) {
        ready = on;
        notifyAll();
    }

    // 状態を考えた上で実行する
    public synchronized void execute() throws InterruptedException, TimeoutException {
        long start = System.currentTimeMillis(); // 開始時刻
        while (!ready) {
            long now = System.currentTimeMillis(); // 現在時刻
            long rest = timeout - (now - start); // 残りの待ち時間
            if (rest <= 0) {
                throw new TimeoutException("now - start = " + (now - start) + ", timeout = " + timeout);
            }
            wait(rest);
        }
        doExecute();
    }

    // 実際の処理
    private void doExecute() {
        System.out.println(Thread.currentThread().getName() + " calls doExecute");
    }
}
