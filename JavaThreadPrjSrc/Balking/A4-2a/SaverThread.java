import java.io.IOException;

public class SaverThread extends Thread {
    private final Data data;
    public SaverThread(String name, Data data) {
        super(name);
        this.data = data;
    }
    public void run() {
        try {
            while (true) {
                data.save();            // ÉfÅ[É^Çï€ë∂ÇµÇÊÇ§Ç∆Ç∑ÇÈ
                Thread.sleep(1000);     // ñÒ1ïbãxÇﬁ
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
