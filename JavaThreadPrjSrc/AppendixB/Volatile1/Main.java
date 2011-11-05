class Runner extends Thread {
    private boolean quit = false;

    public void run() {
        while (!quit) {
            // ...
        }
        System.out.println("Done");
    }

    public void shutdown() {
        quit = true;
    }
}

public class Main {
    public static void main(String[] args) {
        Runner runner = new Runner();

        // スレッドを起動する
        runner.start();

        // スレッドを終了する
        runner.shutdown();
    }
}
