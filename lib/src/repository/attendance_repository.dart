import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/attendance.dart';
import 'package:iiit_suite/src/models/user.dart';

Future<List<Attendance>> getAttendance() async {
  print('attendance trigger');
  String id = User().getId();
  String password = User().getPassword();
  print(id);
  print(password);
  List<Attendance> attendances = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/attendance',
        data: {"uid": id, "pwd": password});
    for (var n in response.data['Attendance']) {
      attendances.add(Attendance(
          coid: n['coid'],
          days_present: n['days_present'],
          last_updated: n['last_updated'],
          subject: n['subject'],
          total_days: n['total_days']));
    }
    //
//    await NoticeDao().deleteDB();
    //
    print('fetched attendances');
    for (Attendance a in attendances) {
      print(a.subject);
    }
    return attendances;
  } catch (e) {
    print(e);
    print('error in notice repo getAttendance()');
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}
