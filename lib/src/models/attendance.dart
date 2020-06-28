class Attendance {
  String subject, last_updated, coid;
  int total_days, days_present;
  int db_id;
  Attendance(
      {this.coid,
      this.days_present,
      this.last_updated,
      this.subject,
      this.total_days});

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'last_updated': last_updated,
      'coid': coid,
      'total_days': total_days,
      'days_present': days_present
    };
  }

  static Attendance fromMap(Map<String, dynamic> map) {
    return Attendance(
        subject: map['subject'],
        last_updated: map['last_updated'],
        coid: map['coid'],
        total_days: map['total_days'],
        days_present: map['days_present']);
  }
}
