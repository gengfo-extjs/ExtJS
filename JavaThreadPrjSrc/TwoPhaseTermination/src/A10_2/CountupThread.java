package A10_2;

public class CountupThread extends Thread {
  
    private long counter = 0;

    // �I���v��
    public void shutdownRequest() {
        interrupt();
    }

    // ����
    public void run() {
        try {
            while (!isInterrupted()) {
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
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
        }
    }

    // �I������
    private void doShutdown() {
        System.out.println("doShutdown: counter = " + counter);
    }
}
