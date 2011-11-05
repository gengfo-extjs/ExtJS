public class Main {
    public static void main(String[] args) {
        // スレッドA
        new Thread() {
            public void run() {
                System.out.println(MySystem.getInstance().getDate());
            }
        }.start();

        // スレッドB
        new Thread() {
            public void run() {
                System.out.println(MySystem.getInstance().getDate());
            }
        }.start();
    }
}
