class User {
  static String id, password;
  void write(String i, String p) {
    id = i;
    password = p;
  }

  String getId() {
    return id;
  }

  String getPassword() {
    return password;
  }
}
