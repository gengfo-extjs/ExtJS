import java.util.concurrent.*;

class Log {
    public static void println(String s) {
        System.out.println(Thread.currentThread().getName() + ":" + s);
    }
}

public class Main {
    public static void main(String[] args) {
        Thread.currentThread().setName("MainThread");
        Log.println("main:BEGIN");

        // ThreadFactory
        final ThreadFactory threadFactory = new ThreadFactory() {
            public Thread newThread(Runnable r) {
                Log.println("newThread:BEGIN");
                Thread t = new Thread(r, "QuizThread");
                Log.println("newThread:END");
                return t;
            }
        };

        // Executor
        Executor executor = new Executor() {
            public void execute(Runnable r) {
                Log.println("execute:BEGIN");
                threadFactory.newThread(r).start();
                Log.println("execute:END");
            }
        };

        // Runnable
        Runnable runnable = new Runnable() {
            public void run() {
                Log.println("run:BEGIN");
                Log.println("Hello!");
                Log.println("run:END");
            }
        };

        // ExecutorÇ…RunnableÇìnÇµÇƒé¿çs
        executor.execute(runnable);

        Log.println("main:END");
    }
}
