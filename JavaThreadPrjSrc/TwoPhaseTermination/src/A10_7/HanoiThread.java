package A10_7;

public class HanoiThread extends Thread {
    // �I���v�����o���ꂽ��true
    private volatile boolean shutdownRequested = false;
    // �I���v�����o���ꂽ����
    private volatile long requestedTimeMillis = 0;

    // �I���v��
    public void shutdownRequest() {
        requestedTimeMillis = System.currentTimeMillis();
        shutdownRequested = true;
        interrupt();
    }

    // �I���v�����o���ꂽ���ǂ����̃e�X�g
    public boolean isShutdownRequested() {
        return shutdownRequested;
    }

    // ����
    public void run() {
        try {
            for (int level = 0; !isShutdownRequested(); level++) {
                System.out.println("==== Level " + level + " ====");
                doWork(level, 'A', 'B', 'C');
                System.out.println("");
            }
        } catch (InterruptedException e) {
        } finally {
            doShutdown();
        }
    }

    // ���
    private void doWork(int level, char posA, char posB, char posC) throws InterruptedException {
        if (level > 0) {
            if (isShutdownRequested()) {
                throw new InterruptedException();
            }
            doWork(level - 1, posA, posC, posB);
            System.out.print(posA + "->" + posB + " ");
            doWork(level - 1, posC, posB, posA);
        }
    }

    // �I������
    private void doShutdown() {
        long time = System.currentTimeMillis() - requestedTimeMillis;
        System.out.println("doShutdown: Latency = " + time + " msec.");
    }
}
