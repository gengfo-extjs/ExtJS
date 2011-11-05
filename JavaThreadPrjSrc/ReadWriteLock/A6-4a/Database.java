import java.util.Map;
import java.util.HashMap;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class Database<K,V> {
    private final Map<K,V> map = new HashMap<K,V>();

    private final ReadWriteLock lock = new ReentrantReadWriteLock(true /* fair */);
    private final Lock readLock = lock.readLock();
    private final Lock writeLock = lock.writeLock();

    // すべてクリアする
    public void clear() {
        writeLock.lock();
        try {
            verySlowly();
            map.clear();
        } finally {
            writeLock.unlock();
        }
    }

    // keyにvalueを割り当てる
    public void assign(K key, V value) {
        writeLock.lock();
        try {
            verySlowly();
            map.put(key, value);
        } finally {
            writeLock.unlock();
        }
    }

    // keyに割り当てた値を取得する
    public V retrieve(K key) {
        readLock.lock();
        try {
            slowly();
            return map.get(key);
        } finally {
            readLock.unlock();
        }
    }

    // 処理に時間がかかることをシミュレートする
    private void slowly() {
        try {
            Thread.sleep(50);
        } catch (InterruptedException e) {
        }
    }

    // 処理にとても時間がかかることをシミュレートする
    private void verySlowly() {
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
        }
    }
}
