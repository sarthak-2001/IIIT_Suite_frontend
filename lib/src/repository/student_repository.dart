import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/student.dart';

Future<List<Student>> getStudents(String string) async {
  List<Student> students = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/students',
        data: {"uid": "b418045", "pwd": "kitu@2001", "search": string});
    for (var n in response.data['student']) {
      students.add(Student(
        id: n['id'],
        link: n['link'],
        name: n['name'],
      ));
    }
    print(students);
    return students;
  } catch (e) {
    print('error in notice repo getStudent()');
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return [];
  }
}
