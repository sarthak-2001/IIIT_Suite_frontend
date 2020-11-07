import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/faculty.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/config/api_request.dart';

Future<List<Faculty>> getFaculty() async {
  String id = User().getId();
  String password = User().getPassword();
  print(id);
  print('faculty trigger');
  List<Faculty> faculties = [];
  try {
    Response response =
        await Dio().post(faculty, data: {"uid": id, "pwd": password});
    for (var map in response.data['faculty']) {
      faculties.add(Faculty(
          id: map['id'],
          dept: map['dept'],
          link: map['link'],
          name: map['name']));
    }

    print('fetched faculty');
    print(faculties.length);
//    for (Faculty a in faculties) {
//      print(a.name);
//    }

    faculties.sort((a, b) {
      return a.dept
          .toString()
          .toLowerCase()
          .compareTo(b.dept.toString().toLowerCase());
    });
    return faculties;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}

Future<String> getFacultyImage(String link1) async {
  String id = User().getId();
  String password = User().getPassword();
  String link;
  try {
    Response response = await Dio()
        .post(facultyImage, data: {"uid": id, "pwd": password, "link": link1});

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
