import 'package:flutter/material.dart';
import 'package:iiit_suite/src/repository/attendance_repository.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              await getAttendance();
            },
            child: Text('Attenance'),
          ),
          RaisedButton(
            onPressed: () async {
              await getGrade();
            },
            child: Text('grade'),
          )
        ],
      ),
    );
  }
}
