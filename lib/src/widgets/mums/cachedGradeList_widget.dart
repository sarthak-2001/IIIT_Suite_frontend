import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/grades_controller.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart';

class CachedGradeListWidget extends StatelessWidget {
  final int sem;
  CachedGradeListWidget({this.sem});
  @override
  Widget build(BuildContext context) {
    if (GradeController.noData == true)
      return Expanded(
        child: Center(
          child: Text(
            'Nothing to see here',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    return FutureBuilder<List<Grade>>(
        future: GradeDao().getGradesBySem(sem),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data.length == 0)
            return Expanded(
              child: Center(
                child: SpinKitFadingGrid(color: Colors.white70),
              ),
            );
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                List<Grade> grades = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: kForegroundColour,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 4,
                                  height: 24,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${grades[index].subject}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Credits : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].credit}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Teacher Assesment : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].ta == 0.0 ? '_' : grades[index].ta}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Quiz-1 : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].quiz_1 == 0.0 ? '_' : grades[index].quiz_1}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Quiz-2 : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].quiz_2 == 0.0 ? '_' : grades[index].quiz_2}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'MidSem : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].midsem == 0.0 ? '_' : grades[index].midsem}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'EndSem : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].endsem == 0.0 ? '_' : grades[index].endsem}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Grade Points : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].grade_points == 0.0 ? '_' : grades[index].grade_points}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Grades : ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${grades[index].grade == '' ? '_' : grades[index].grade}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
