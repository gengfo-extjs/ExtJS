public class Something {
    private boolean initialized = false;
    public synchronized void init() {
        if (initialized) {
            return;
        }
        doInit();
        initialized = true;
    }
    private void doInit() {
        // ÀÛ‚Ì‰Šú‰»ˆ—
    }
}
