import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:iiit_suite/src/repository/user_repository.dart';

Future<List<Grade>> getGrade() async {
  print('grrade trigger');
  String id = await getId();
  String password = await getPassword();
  List<Grade> grades = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/grades',
        data: {"uid": id, "pwd": password, "sem": "3"});
    for (var map in response.data['grades']) {
      grades.add(Grade(
          subject: map['subject'],
          grade: map['grade'] ?? '',
          semester: map['semester'],
          coid: map['coid'],
          credit: map['credit'],
          quiz_1: map['quiz_1'] ?? 0.0,
          quiz_2: map['quiz_2'] ?? 0.0,
          midsem: map['midsem'] ?? 0.0,
          ta: map['ta'] ?? 0.0,
          endsem: map['endsem'] ?? 0.0,
          grade_points: map['grade_points'] ?? 0.0));
    }
    //
//    await NoticeDao().deleteDB();
    //
    print('fetched grades');
    for (Grade a in grades) {
      print(a.subject);
    }
    return grades;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}
