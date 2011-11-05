public class Main {
    public static void main(String[] args) {
        new PrintThread("*").run();
        new PrintThread("+").run();
    }
}
