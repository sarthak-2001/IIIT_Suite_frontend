import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/attendance.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:iiit_suite/src/repository/attendance_repository.dart' as Repo;

class AttendanceController extends ControllerMVC{
  static List<Attendance> attendance;
  GlobalKey<ScaffoldState> scaffoldKey;

  AttendanceController(){
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void getAttendanceList() async{
    List<Attendance> a = await Repo.getAttendance();
    setState(() => attendance = a);
  }

  Future<void> refreshAttendance() async {
    setState(() {
      attendance = [];
    });
    await getAttendanceList();
  }
}