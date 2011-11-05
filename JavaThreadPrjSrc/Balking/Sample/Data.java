import java.io.IOException;
import java.io.FileWriter;
import java.io.Writer;

public class Data {
    private final String filename;  // 保存するファイルの名前
    private String content;         // データの内容
    private boolean changed;        // 変更した内容が保存されていないならtrue

    public Data(String filename, String content) {
        this.filename = filename;
        this.content = content;
        this.changed = true;
    }

    // データの内容を書き換える
    public synchronized void change(String newContent) {
        content = newContent;
        changed = true;
    }

    // データの内容が変更されていたらファイルに保存する
    public synchronized void save() throws IOException {
        if (!changed) {
            return;
        }
        doSave();
        changed = false;
    }

    // データの内容を実際にファイルに保存する
    private void doSave() throws IOException {
        System.out.println(Thread.currentThread().getName() + " calls doSave, content = " + content);
        Writer writer = new FileWriter(filename);
        writer.write(content);
        writer.close();
    }
}
