class Faculty {
  String name, dept, link;
  int id;
  int db_id;

  Faculty({this.id, this.dept, this.link, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'dept': dept, 'link': link, 'name': name};
  }

  static Faculty fromMap(Map<String, dynamic> map) {
    return Faculty(
        id: map['id'], dept: map['dept'], link: map['link'], name: map['name']);
  }
}
