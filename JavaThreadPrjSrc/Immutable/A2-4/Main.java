public class Main {
    public static void main(String[] args) {
        // インスタンス作成
        UserInfo userinfo = new UserInfo("Alice", "Alaska");

        // 表示
        System.out.println("userinfo = " + userinfo);

        // 状態を変更
        StringBuffer info = userinfo.getInfo();
        info.replace(12, 17, "Bobby");  // 12以上17未満が"Alice"の位置

        // 再度表示
        System.out.println("userinfo = " + userinfo);
    }
}
