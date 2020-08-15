import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/student.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/api_request.dart';

Future<List<Student>> getStudents(String string) async {
  String id = User().getId();
  String password = User().getPassword();
  List<Student> students = [];
  try {
    Response response = await Dio().post(
        student,
        data: {"uid": id, "pwd": password, "search": string});
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

Future<String> getStudentImage(String link1) async {
  print(link1);
  String id = User().getId();
  String password = User().getPassword();
  String link;
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/stuimg',
        data: {"uid": id, "pwd": password, "link": link1});

    link = response.data['link'];
    print('fetched link');
    print(link);
    return link;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}
