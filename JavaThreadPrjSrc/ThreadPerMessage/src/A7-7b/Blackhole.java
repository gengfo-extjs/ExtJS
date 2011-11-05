public class Blackhole {
    public static void enter(Object obj) {
        System.out.println("Step 1");
        magic(obj);
        System.out.println("Step 2");
        synchronized (obj) {
            System.out.println("Step 3 (never reached here)");  // ここにはこない
        }
    }
    public static void magic(final Object obj) {
        // threadは、objのロックを取ってから自分自身の終了を永遠に待つスレッド
        Thread thread = new Thread() {
            public void run() {
                synchronized (obj) {        // ここでobjのロックを取る
                    synchronized (this) {
                        this.notifyAll();   // objのロックを取ったことを通知
                    }
                    try {
                        this.join(); // 永遠に待つことになる
                    } catch (InterruptedException e) {
                    }
                }
            }
        };
        synchronized (thread) {
            thread.start();     // スレッドの起動
            try {
                thread.wait();  // 新しいスレッドがobjのロックを取るのを待つ
            } catch (InterruptedException e) {
            }
        }
    }
}
