import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:sembast/sembast.dart';

Future<List<Grade>> getGrade(String sem) async {
  print('grrade trigger');
  String id = User().getId();
  String password = User().getPassword();
  List<Grade> grades = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/grades',
        data: {"uid": id, "pwd": password, "sem": sem});
//    Response response = await Dio().post(
//        'https://sarthak-mums-iiit.herokuapp.com/grades',
//        data: {"uid": id, "pwd": password, "sem": "3"});
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

      GradeDao().insert(Grade(
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
//    for (Grade a in grades) {
//      print(a.grade);
//    }
    return grades;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}

class GradeDao {
  static const String STORE_NAME = 'grades';
  final _gradeStore = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Grade grade) async {
    final finder = Finder(filter: Filter.equals('coid', grade.coid));
    var isUpdated =
        await _gradeStore.update(await _db, grade.toMap(), finder: finder);
    if (isUpdated == 0) {
      await _gradeStore.add(await _db, grade.toMap());
    }
  }

  Future<List<Grade>> getGradesBySem(int sem) async {
    var finder = Finder(filter: Filter.equals('semester', sem));
    final recordSnapshots = await _gradeStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final grade = Grade.fromMap(snapshot.value);
      grade.db_id = snapshot.key;
      return grade;
    }).toList();
  }

  Future deleteDB() async {
    await _gradeStore.drop(await _db);
  }
}
