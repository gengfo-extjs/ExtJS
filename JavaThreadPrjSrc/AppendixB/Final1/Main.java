class Something {
    // finalなインスタンスフィールド
    private final int x;
    // クラスフィールド
    private static Something last = null;

    // コンストラクタ
    public Something() {
        // finalフィールドを明示的に初期化する
        x = 123;
        // クラスフィールドに作成中のインスタンス(this)を保存する
        last = this;
    }

    // last経由でfinalフィールドの値を表示する
    public static void print() {
        if (last != null) {
            System.out.println(last.x);
        }
    }
}

public class Main {
    public static void main(String[] args) {
        // スレッドA
        new Thread() {
            public void run() {
                new Something();
            }
        }.start();

        // スレッドB
        new Thread() {
            public void run() {
                Something.print();
            }
        }.start();
    }
}
