package Sample;

public class CountupThread extends Thread {
    // �J�E���^�̒l
    private long counter = 0;

    // �I���v�����o���ꂽ��true
    private volatile boolean shutdownRequested = false;

    // �I���v��
    public void shutdownRequest() {
        shutdownRequested = true;
        interrupt();
    }

    // �I���v�����o���ꂽ���ǂ����̃e�X�g
    public boolean isShutdownRequested() {
        return shutdownRequested;
    }

    // ����
    public final void run() {
        try {
            while (!isShutdownRequested()) {
                doWork();
            }
        } catch (InterruptedException e) {
        } finally {
            doShutdown();
        }
    }

    // ���
    private void doWork() throws InterruptedException {
        counter++;
        System.out.println("doWork: counter = " + counter);
        Thread.sleep(500);
    }

    // �I������
    private void doShutdown() {
        System.out.println("doShutdown: counter = " + counter);
    }
}
