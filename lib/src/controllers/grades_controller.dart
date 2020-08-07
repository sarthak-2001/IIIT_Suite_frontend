import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart' as Repo;

class GradeController extends ControllerMVC {
  static List<Grade> grade;
  static bool noData = false;
  GlobalKey<ScaffoldState> scaffoldKey;

  GradeController() {
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  Future<void> getGradeList(String sem) async {
    print('I was called');
    setState(() {
      grade = null;
    });
//    List<Grade> g =
    await Repo.getGrade(sem).then((value) {
      setState(() {
        grade = value;
        if (value.length == 0)
          noData = true;
        else
          noData = false;
      });
    });
  }

  Future<void> refreshGrade(String sem) async {
    setState(() {
      grade = null;
      noData = false;
    });
    await getGradeList(sem);
  }
}
