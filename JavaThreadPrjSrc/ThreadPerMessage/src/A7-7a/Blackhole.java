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
        // threadはobjのロックを取って無限ループするスレッド
        // threadの名前をガード条件として使う
        Thread thread = new Thread() {      // inner class
            public void run() {
                synchronized (obj) {        // ここでobjのロックを取る
                    synchronized (this) {
                        this.setName("Locked"); // ガード条件の変化
                        this.notifyAll();       // objのロックを取ったことを通知
                    }
                    while (true) {
                        // 無限ループ
                    }
                }
            }
        };
        synchronized (thread) {
            thread.setName("");
            thread.start();         // スレッドの起動
            // Guarded Suspensionパターン
            while (thread.getName().equals("")) {
                try {
                    thread.wait();  // 新しいスレッドがobjのロックを取るのを待つ
                } catch (InterruptedException e) {
                }
            }
        }
    }
}
