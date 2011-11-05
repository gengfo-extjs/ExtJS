package Q10_8;

public class Main {
    public static void main(String[] args) {
        // �X���b�h�𐶐�����
        Thread t = new Thread() {
            public void run() {
                while (true) {
                    try {
                        if (Thread.currentThread().isInterrupted()) {
                            throw new InterruptedException();
                        }
                        System.out.print(".");
                    } catch (InterruptedException e) {
                        System.out.print("*");
                    }
                }
            }
        };

        // �X���b�h���N������
        t.start();

        // 5�b�҂�
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
        }

        // �X���b�h�Ɉ�x����interrupt��������
        t.interrupt();
    }
}
