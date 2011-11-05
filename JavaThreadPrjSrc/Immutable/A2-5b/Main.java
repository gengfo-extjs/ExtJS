public class Main {
    public static void main(String[] args) {
        // インスタンス作成
        Point p1 = new Point(0, 0);
        Point p2 = new Point(100, 0);
        Line line = new Line(p1, p2);

        // 表示
        System.out.println("line = " + line);

        // 状態を変更
        p1.x = 150;
        p2.x = 150;
        p2.y = 250;

        // 再度表示
        System.out.println("line = " + line);
    }
}
