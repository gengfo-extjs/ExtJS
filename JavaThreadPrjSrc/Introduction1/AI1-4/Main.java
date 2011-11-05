public class Main {
    public static void main(String[] args) {
        Bank bank = new Bank("A Bad Bank", 1000);   // 1000‰~‚Ì‹âsŒûÀ‚ğì‚é
        new ClientThread(bank).start();
        new ClientThread(bank).start();
    }
}
