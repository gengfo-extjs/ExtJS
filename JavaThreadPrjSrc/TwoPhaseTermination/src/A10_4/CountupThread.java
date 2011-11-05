package A10_4;

public class CountupThread extends GracefulThread {
    // �J�E���^�̒l
    private long counter = 0;

    // ���
    @Override
    protected void doWork() throws InterruptedException {
        counter++;
        System.out.println("doWork: counter = " + counter);
        Thread.sleep(500);
    }

    // �I������
    @Override
    protected void doShutdown() {
        System.out.println("doShutdown: counter = " + counter);
    }
}
