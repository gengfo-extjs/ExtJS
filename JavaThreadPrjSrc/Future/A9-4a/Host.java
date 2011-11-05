public class Host {
    public Data request(final int count, final char c) {
        System.out.println("    request(" + count + ", " + c + ") BEGIN");

        // (1) FutureDataのインスタンスを作る
        final FutureData future = new FutureData();

        // (2) RealDataを作るための新しいスレッドを起動する
        new Thread() {
            public void run() {
                try {
                    RealData realdata = new RealData(count, c);
                    future.setRealData(realdata);
                } catch (Exception e) {
                    future.setException(e);
                }
            }
        }.start();

        System.out.println("    request(" + count + ", " + c + ") END");

        // (3) FutureDataのインスタンスを戻り値とする
        return future;
    }
}
