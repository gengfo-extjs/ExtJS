public final class ReadWriteLock {
    private int readingReaders = 0; // (A) 実際に読んでいる最中のスレッドの数
    private int waitingWriters = 0; // (B) 書くのを待っているスレッドの数
    private int writingWriters = 0; // (C) 実際に書いている最中のスレッドの数
    private boolean preferWriter = true; // 書くのを優先するならtrue

    public synchronized void readLock() throws InterruptedException {
        while (writingWriters > 0 || (preferWriter && waitingWriters > 0)) {
            wait();
        }
        readingReaders++;                       // (A) 実際に読んでいるスレッドの数を1増やす
    }

    public synchronized void readUnlock() {
        readingReaders--;                       // (A) 実際に読んでいるスレッドの数を1減らす
        preferWriter = true;
        notifyAll();
    }

    public synchronized void writeLock() throws InterruptedException {
        waitingWriters++;                       // (B) 書くのを待っているスレッドの数を1増やす
        try {
            while (readingReaders > 0 || writingWriters > 0) {
                wait();
            }
        } finally {
            waitingWriters--;                   // (B) 書くのを待っているスレッドの数を1減らす
        }
        writingWriters++;                       // (C) 実際に書いているスレッドの数を1増やす
    }

    public synchronized void writeUnlock() {
        writingWriters--;                       // (C) 実際に書いているスレッドの数を1減らす
        preferWriter = false;
        notifyAll();
    }
}
