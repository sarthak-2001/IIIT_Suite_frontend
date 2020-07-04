import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/faculty.dart';
import 'package:iiit_suite/src/repository/faculty_repository.dart' as Repo;
import 'package:mvc_pattern/mvc_pattern.dart';

class FacultyController extends ControllerMVC {
  static List<Faculty> faculties;
  GlobalKey<ScaffoldState> scaffoldKey;

  FacultyController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void getFacultyList() async {
    List<Faculty> n = await Repo.getFaculty();
    setState(() => faculties = n);
  }

  Future<void> refreshFaculty() async {
    setState(() {
      faculties = [];
    });
    await Repo.getFaculty();
  }
}
