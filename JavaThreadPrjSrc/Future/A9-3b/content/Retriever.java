package content;

import java.util.concurrent.Callable;

public class Retriever {
    public static Content retrieve(final String urlstr) {
        AsyncContentImpl future = new AsyncContentImpl(
            new Callable<SyncContentImpl>() {
                public SyncContentImpl call() {
                    return new SyncContentImpl(urlstr);
                }
            }
        );

        new Thread(future).start();

        return future;
    }
}
