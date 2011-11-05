class Something {
    // finalなインスタンスフィールド
    private final int x;
    // クラスフィールド
    private static Something last = null;

    // コンストラクタ
    private Something() {
        // finalフィールドを明示的に初期化する
        x = 123;
    }

    // newで得られたインスタンスをlastへ代入する
    public static Something create() {
        last = new Something();
        return last;
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
                Something.create();
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
