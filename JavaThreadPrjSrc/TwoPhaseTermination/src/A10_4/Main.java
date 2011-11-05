package A10_4;

public class Main {
    public static void main(String[] args) {
        System.out.println("main: BEGIN");
        try {
            // �X���b�h�̋N��
            CountupThread t = new CountupThread();
            t.start();

            // �������Ԃ�������
            Thread.sleep(10000);

            // �X���b�h�̏I���v��
            System.out.println("main: shutdownRequest");
            t.shutdownRequest();

            System.out.println("main: join");

            // �X���b�h�̏I����҂�
            t.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("main: END");
    }
}
