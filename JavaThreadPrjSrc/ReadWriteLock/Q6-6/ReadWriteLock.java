public final class ReadWriteLock {
    private int readingReaders = 0; // (a) 実際に読んでいるスレッドの数
    private int writingWriters = 0; // (b) 実際に書いているスレッドの数

    public synchronized void readLock() throws InterruptedException {
        while (writingWriters > 0) {
            wait();
        }
        readingReaders++;                       // (a) 実際に読んでいるスレッドの数を1増やす
    }

    public synchronized void readUnlock() {
        readingReaders--;                       // (a) 実際に読んでいるスレッドの数を1減らす
        notifyAll();
    }

    public synchronized void writeLock() throws InterruptedException {
        while (readingReaders > 0 || writingWriters > 0) {
            wait();
        }
        writingWriters++;                       // (b) 実際に書いているスレッドの数を1増やす
    }

    public synchronized void writeUnlock() {
        writingWriters--;                       // (b) 実際に書いているスレッドの数を1減らす
        notifyAll();
    }
}
