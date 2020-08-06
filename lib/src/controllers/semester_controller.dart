import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/semester.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:iiit_suite/src/repository/semester_repository.dart' as Repo;

class SemesterController extends ControllerMVC {
  static Semester semester;
  GlobalKey<ScaffoldState> scaffoldKey;

  SemesterController() {
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void getSemesterList() async {
    Semester s = await Repo.getSemester();
    setState(() => semester = s);
  }

  Future<void> refreshSem() async {
    setState(() {
      semester = Semester(cgpa: '_', sgpa: []);
    });
    await getSemesterList();
  }
}
