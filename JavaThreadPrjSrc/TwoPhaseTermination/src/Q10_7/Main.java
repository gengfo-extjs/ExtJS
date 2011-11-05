package Q10_7;

public class Main {
    public static void main(String[] args) {
        System.out.println("main: BEGIN");
        try {
            // �X���b�h�̋N��
            HanoiThread t = new HanoiThread();
            t.start();

            // �������Ԃ�������
            Thread.sleep(10000);

            // �X���b�h�̏I���v��
            System.out.println("main: shutdownRequest");
            t.shutdownRequest();

            // �X���b�h�̏I����҂�
            System.out.println("main: join");
            t.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("main: END");
    }
}
