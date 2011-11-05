package A10_5;

public class GracefulThread extends Thread {
    // �I���v�����o���ꂽ��true
    private volatile boolean shutdownRequested = false;

    // �I���v��
    public final void shutdownRequest() {
        shutdownRequested = true;
        interrupt();
    }

    // �I���v�����o���ꂽ���ǂ����̃e�X�g
    public final boolean isShutdownRequested() {
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
    protected void doWork() throws InterruptedException {
    }

    // �I������
    protected void doShutdown() {
    }
}
