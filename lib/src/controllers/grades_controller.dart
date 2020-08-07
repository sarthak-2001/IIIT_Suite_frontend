import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart' as Repo;

class GradeController extends ControllerMVC {
  static List<Grade> grade;
  GlobalKey<ScaffoldState> scaffoldKey;

  GradeController() {
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void getGradeList(String sem) async {
    List<Grade> g = await Repo.getGrade(sem);
    setState(() => grade = g);
  }

  Future<void> refreshGrade(String sem) async {
    setState(() {
      grade = [];
    });
    await getGradeList(sem);
  }
}
