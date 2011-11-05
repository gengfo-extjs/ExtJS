public class Bank {
    private int money;
    private String name;

    public Bank(String name, int money) {
        this.name = name;
        this.money = money;
    }

    // 預金する
    public synchronized void deposit(int m) {
        money += m;
    }

    // 引き出す
    public synchronized boolean withdraw(int m) {
        if (money >= m) {
            money -= m;
            return true;    // 引き出せた
        } else {
            return false;   // 残高不足
        }
    }

    public String getName() {
        return name;
    }
}
