package A10_8;

public class Main {
    public static void main(String[] args) {
        // �X���b�h�𐶐�����
        Thread thread = new Thread() {
            public void run() {
                while (true) {
                    try {
                        if (Thread.interrupted()) {
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
        thread.start();

        // 5�b�҂�
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
        }

        // �X���b�h�Ɉ�x����interrupt��������
        thread.interrupt();
    }
}
