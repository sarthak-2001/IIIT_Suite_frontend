class User {
  static String id, password, name;
  void write(String i, String p, String n) {
    id = i;
    password = p;
    name = n;
  }

  String getId() {
    return id;
  }

  String getPassword() {
    return password;
  }

  String getname() {
    return name;
  }
}
