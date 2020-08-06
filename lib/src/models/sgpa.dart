class Sgpa {
  final String sems;
  final String points;

  Sgpa({this.sems, this.points});

  Map<String, dynamic> toMap() {
    return {'sem': sems, 'sgpa': points};
  }

  static Sgpa fromMap(Map<String, dynamic> map) {
    return Sgpa(
      sems: map['sem'].toString(),
      points: map['sgpa'].toString(),
    );
  }
}
