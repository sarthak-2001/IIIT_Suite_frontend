import 'package:flutter/material.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/sgpa.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/semester.dart';
import 'package:dio/dio.dart';
import 'package:iiit_suite/src/config/api_request.dart';
import 'package:sembast/sembast.dart';

Future<Semester> getSemester() async {
  print('Semester Triggers');
  String id = User().getId();
  String password = User().getPassword();
  List<Sgpa> sgpa = [];
  try {
    Response response =
        await Dio().post(semesters, data: {"uid": id, "pwd": password});

    String cgpa = (response.data['sems'][0]['cgpa']).toString();

    for (int i = 1; i <= 8; i++) {
      sgpa.add(Sgpa.fromMap(response.data['sems'][i]));
    }
    await SemesterDao().deleteDB();

    for (Sgpa s in sgpa) {
      await SemesterDao().insert(s);
    }

    Semester semester = Semester(cgpa: cgpa, sgpa: sgpa);
    await CgpaDao().insert(semester);
    print('fetched Semester');
    return semester;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
  }
}

class SemesterDao {
  static const String STORE_NAME = 'semester';
  final _semesterStore = intMapStoreFactory.store(STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Sgpa sgpa) async {
    print('stuff added to sem');
    await _semesterStore.add(await _db, sgpa.toMap());
  }

  Future<List<Sgpa>> getSem() async {
//    var finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshots = await _semesterStore.find(await _db);
    final x = await _semesterStore.find(await _db);
    print(x.length);
    return recordSnapshots.map((snapshot) {
      final s = Sgpa.fromMap(snapshot.value);
      return s;
    }).toList();
  }

  Future deleteDB() async {
    await _semesterStore.drop(await _db);
  }
}

class CgpaDao {
  static const String STORE_NAME = 'cgpa';
  final _cgpaStore = intMapStoreFactory.store(STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Semester semester) async {
    await this.deleteDB();
    final finder = Finder(filter: Filter.equals('cgpa', semester.cgpa));
    var isUpdated = await _cgpaStore.update(await _db, {'cgpa': semester.cgpa},
        finder: finder);
    if (isUpdated == 0) {
      print('stuff added to sem');
      await _cgpaStore.add(await _db, {'cgpa': semester.cgpa});
    }
  }

  Future<String> getCgpa() async {
//    var finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshots = await _cgpaStore.findFirst(await _db);
    final x = await _cgpaStore.find(await _db);
    print(x.length);
    print(recordSnapshots.value['cgpa']);
    return recordSnapshots.value['cgpa'];
  }

  Future deleteDB() async {
    await _cgpaStore.drop(await _db);
  }
}
