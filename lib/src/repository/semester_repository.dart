import 'package:iiit_suite/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/semester.dart';
import 'package:dio/dio.dart';

Future<List<Semester>> getSemester() async{
  print('Semester Triggers');
  String id = User().getId();
  String password = User().getPassword();
  List<Semester> semesters = [];
  try{
    Response response = await Dio().post(
      'https://sarthak-mums-iiit.herokuapp.com/sem',
        data: {"uid": id, "pwd": password}
    );
    for(var s in response.data['sems']){
      semesters.add(Semester(
        cgpa: s['cgpa'],
        sgpa: s['sgpa'],
      ));
    }
    print('fetched Semester');
    for (Semester s in semesters) {
      print(s.sgpa);
    }
    return semesters;
  }catch(e){
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG
    );
    return null;
  }
}