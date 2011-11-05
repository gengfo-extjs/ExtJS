import java.util.concurrent.Callable;

public class Host {
    public FutureData request(final int count, final char c) {
        System.out.println("    request(" + count + ", " + c + ") BEGIN");

        // (1) FutureDataのインスタンスを作る
        //     （コンストラクタにCallable<RealData>を渡す）
        FutureData future = new FutureData(
            new Callable<RealData>() {
                public RealData call() {
                    return new RealData(count, c);
                }
            }
        );

        // (2) RealDataを作るための新しいスレッドを起動する
        new Thread(future).start();

        System.out.println("    request(" + count + ", " + c + ") END");

        // (3) FutureDataのインスタンスを戻り値とする
        return future;
    }
}
