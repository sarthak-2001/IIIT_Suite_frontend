import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/attendance.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/api_request.dart';
import 'package:sembast/sembast.dart';

class AttendanceDao{
  static const String STORE_NAME = 'attendance';
  final _attendanceStore = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Attendance attendance) async{
    final finder =Finder(filter: Filter.equals('coid', attendance.coid));
    var isUpdated =
    await _attendanceStore.update(await _db, attendance.toMap(), finder: finder);
    if (isUpdated == 0) {
      await _attendanceStore.add(await _db, attendance.toMap());
    }
  }

  Future<List<Attendance>> getAllSortedByID() async {
    var finder = Finder(sortOrders: [SortOrder('coid')]);
    final recordSnapshots = await _attendanceStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final attendance = Attendance.fromMap(snapshot.value);
      attendance.db_id = snapshot.key;
      return attendance;
    }).toList();
  }

  Future deleteDB() async {
    await _attendanceStore.drop(await _db);
  }
}

Future<List<Attendance>> getAttendance() async {
  print('attendance trigger');
  String id = User().getId();
  String password = User().getPassword();
  print(id);
  print(password);
  List<Attendance> attendances = [];
  try {
    Response response = await Dio().post(
        attendance,
        data: {"uid": id, "pwd": password});
    for (var n in response.data['Attendance']) {
      attendances.add(Attendance(
          coid: n['coid'],
          days_present: n['days_present'],
          last_updated: n['last_updated'],
          subject: n['subject'],
          total_days: n['total_days']));

      AttendanceDao().insert(Attendance(
          coid: n['coid'],
          days_present: n['days_present'],
          last_updated: n['last_updated'],
          subject: n['subject'],
          total_days: n['total_days']));
    }
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
