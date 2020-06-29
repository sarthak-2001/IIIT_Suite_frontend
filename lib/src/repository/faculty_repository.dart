import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/faculty.dart';

Future<List<Faculty>> getFaculty() async {
  print('faculty trigger');
  List<Faculty> faculties = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/facList',
        data: {"uid": "b418045", "pwd": "kitu@2001"});
    for (var map in response.data['faculty']) {
      faculties.add(Faculty(
          id: map['id'],
          dept: map['dept'],
          link: map['link'],
          name: map['name']));
    }
    //
//    await NoticeDao().deleteDB();
    //
    print('fetched faculty');
//    for (Faculty a in faculties) {
//      print(a.name);
//    }
    return faculties;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}

Future<String> getFacultyImage() async {
  String link;
  try {
    Response response = await Dio()
        .post('https://sarthak-mums-iiit.herokuapp.com/facimg', data: {
      "uid": "b418045",
      "pwd": "kitu@2001",
      "link": "facDet.php?facid=1056"
    });

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
