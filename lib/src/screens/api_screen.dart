import 'package:flutter/material.dart';
import 'package:iiit_suite/src/repository/attendance_repository.dart';
import 'package:iiit_suite/src/repository/book_repository.dart';
import 'package:iiit_suite/src/repository/faculty_repository.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart';
import 'package:iiit_suite/src/repository/semester_repository.dart';
import 'package:iiit_suite/src/repository/student_repository.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  TextEditingController _stu = TextEditingController();
  TextEditingController _book = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                await getAttendance();
              },
              child: Text('Attenance'),
            ),
            RaisedButton(
              onPressed: () async {
                await getSemester();
              },
              child: Text('Sems'),
            ),
            RaisedButton(
              onPressed: () async {
                await getGrade("3");
              },
              child: Text('grade'),
            ),
            RaisedButton(
              onPressed: () async {
                await getFaculty();
              },
              child: Text('fac'),
            ),
//            RaisedButton(
//              onPressed: () async {
//                await getFacultyImage();
//              },
//              child: Text('fac Image'),
//            ),
            TextFormField(
              controller: _stu,
              validator: (v) {
                if (v == null || v == '') return 'Cant be empty';
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5.0),
              )),
            ),
            RaisedButton(
              onPressed: () async {
                await getStudents(_stu.text);
              },
              child: Text('stu search'),
            ),
            TextFormField(
              controller: _book,
              validator: (v) {
                if (v == null || v == '') return 'Cant be empty';
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5.0),
              )),
            ),
            RaisedButton(
              onPressed: () async {
                await getBooks(_book.text);
              },
              child: Text('book search'),
            ),
          ],
        ),
      ),
    );
  }
}
