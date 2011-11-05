public class Main {
    public static void main(String[] args) {
        // スレッドを起動する
        RequestQueue requestQueue = new RequestQueue();
        Thread alice = new ClientThread(requestQueue, "Alice", 314159L);
        Thread bobby = new ServerThread(requestQueue, "Bobby", 265358L);
        alice.start();
        bobby.start();

        // 約10秒待つ
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
        }

        // interruptメソッドを呼ぶ
        System.out.println("***** calling interrupt *****");
        alice.interrupt();
        bobby.interrupt();
    }
}
