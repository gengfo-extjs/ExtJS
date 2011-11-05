package Hook;

public class Main {
    public static void main(String[] args) {
        System.out.println("main:BEGIN");

        // (1) �L���b�`����Ȃ���O�̃n���h����ݒ肷��
        Thread.setDefaultUncaughtExceptionHandler(
            new Thread.UncaughtExceptionHandler() {
                public void uncaughtException(Thread thread, Throwable exception) {
                    System.out.println("****");
                    System.out.println("UncaughtExceptionHandler:BEGIN");
                    System.out.println("currentThread = " + Thread.currentThread());
                    System.out.println("thread = " + thread);
                    System.out.println("exception = " + exception);
                    System.out.println("UncaughtExceptionHandler:END");
                }
            }
        );

        // (2) �V���b�g�_�E���E�t�b�N��ݒ肷��
        Runtime.getRuntime().addShutdownHook(
            new Thread() {
                public void run() {
                    System.out.println("****");
                    System.out.println("shutdown hook:BEGIN");
                    System.out.println("currentThread = " + Thread.currentThread());
                    System.out.println("shutdown hook:END");
                }
            }
        );

        // (3) ��3�b��Ɂu0�ɂ�鐮���̊���Z�v���s���X���b�h���N������
        new Thread("MyThread") {
            public void run() {
                System.out.println("MyThread:BEGIN");
                System.out.println("MyThread:SLEEP...");

                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                }

                System.out.println("MyThread:DIVIDE");

                // �u0�ɂ�鐮���̊���Z�v
                int x = 1 / 0;

                // �����ɂ͗��Ȃ�
                System.out.println("MyThread:END");
            }
        }.start();

        System.out.println("main:END");
    }
}
