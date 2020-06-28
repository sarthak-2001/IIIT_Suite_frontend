class Grade {
  String subject, grade;
  int coid;
  dynamic semester, credit, quiz_1, quiz_2, midsem, ta, endsem, grade_points;

  Grade(
      {this.subject,
      this.coid,
      this.credit,
      this.endsem,
      this.grade,
      this.grade_points,
      this.midsem,
      this.quiz_1,
      this.quiz_2,
      this.semester,
      this.ta});

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'grade': grade,
      'semester': semester,
      'coid': coid,
      'credit': credit,
      'quiz_2': quiz_2,
      'quiz_1': quiz_1,
      'midsem': midsem,
      'ta': ta,
      'endsem': endsem,
      'grade_points': grade_points
    };
  }

  static Grade fromMap(Map<String, dynamic> map) {
    return Grade(
        subject: map['subject'],
        grade: map['grade'],
        semester: map['semester'],
        coid: map['coid'],
        credit: map['credit'],
        quiz_1: map['quiz_1'],
        quiz_2: map['quiz_2'],
        midsem: map['midsem'],
        ta: map['ta'],
        endsem: map['endsem'],
        grade_points: map['grade_points']);
  }
}
