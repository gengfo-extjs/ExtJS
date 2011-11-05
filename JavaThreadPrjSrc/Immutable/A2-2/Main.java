public class Main {
    public static void main(String[] args) {
        String s = "BAT";
        String t = s.replace('B', 'C'); // 'B'‚ğ'C'‚É’uŠ·
        System.out.println("s = " + s); // replace‚ğÀs‚µ‚½Œã‚Ìs
        System.out.println("t = " + t); // replace‚Ì–ß‚è’lt
        if (s == t) {
            System.out.println("s == t");
        } else {
            System.out.println("s != t");
        }
    }
}
