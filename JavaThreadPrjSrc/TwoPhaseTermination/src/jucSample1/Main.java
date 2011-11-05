package jucSample1;

import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.CountDownLatch;

public class Main {
    private static final int TASKS = 10; // �d���̌�

    public static void main(String[] args) {
        System.out.println("BEGIN");
        ExecutorService service = Executors.newFixedThreadPool(5);
        CountDownLatch doneLatch = new CountDownLatch(TASKS);
        try {
            // �d�����J�n����
            for (int t = 0; t < TASKS; t++) {
                service.execute(new MyTask(doneLatch, t));
            }
            System.out.println("AWAIT");
            // �d���̏I����҂�
            doneLatch.await();
        } catch (InterruptedException e) {
        } finally {
            service.shutdown();
            System.out.println("END");
        }
    }
}
