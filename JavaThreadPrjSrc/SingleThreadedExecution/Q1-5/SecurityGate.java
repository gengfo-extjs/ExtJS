public class SecurityGate {
    private int counter = 0;
    public void enter() {
        counter++;
    }
    public void exit() {
        counter--;
    }
    public int getCounter() {
        return counter;
    }
}
