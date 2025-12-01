class UserSession {
  static int userId = 0; // untuk id_user
  static String name = "";
  static String email = "";
  static String phone = "";

  static void clear() {
    userId = 0;
    name = "";
    email = "";
    phone = "";
  }
}
