import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart' as Repo;

class GradeController extends ControllerMVC{
  static List<Grade> grade;
  GlobalKey<ScaffoldState> scaffoldKey;

  GradeController(){
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void getGradeList() async{
    List<Grade> g = await Repo.getGrade();
    setState(() => grade =g);
  }

  Future<void> refreshGrade() async{
    setState((){
      grade =[];
    });
    await getGradeList();
  }
}