import java.util.Map;
import java.util.HashMap;

public class Database<K,V> {
    private final Map<K,V> map = new HashMap<K,V>();

    // すべてクリアする
    public synchronized void clear() {
        verySlowly();
        map.clear();
    }

    // keyにvalueを割り当てる
    public synchronized void assign(K key, V value) {
        verySlowly();
        map.put(key, value);
    }

    // keyに割り当てた値を取得する
    public synchronized V retrieve(K key) {
        slowly();
        return map.get(key);
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
