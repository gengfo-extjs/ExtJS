package Q10_5;

public class Service {
    // �T�[�r�X���s�J�n
    public static void service() {
        System.out.print("service");
        for (int i = 0; i < 50; i++) {
            System.out.print(".");
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
            }
        }
        System.out.println("done.");
    }

    // �T�[�r�X���~
    public static void cancel() {
        // ������
    }
}
