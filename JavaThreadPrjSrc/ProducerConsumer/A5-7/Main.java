public class Main {
    public static void main(String[] args) {
        // Hostの重い処理を実行するスレッド
        Thread executor = new Thread() {
            public void run() {
                System.out.println("Host.execute BEGIN");
                try {
                    Host.execute(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("Host.execute END");
            }
        };

        // 起動する
        executor.start();

        // 約15秒休む
        try {
            Thread.sleep(15000);
        } catch (InterruptedException e) {
        }

        // キャンセル実行
        System.out.println("***** interrupt *****");
        executor.interrupt();
    }
}
