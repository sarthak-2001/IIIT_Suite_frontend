import 'package:flutter/material.dart';
import 'package:iiit_suite/src/controllers/grades_controller.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../constants.dart';

class SemesterDetailsScreen extends StatefulWidget {
  final String sem;
  SemesterDetailsScreen({@required this.sem});
  @override
  _SemesterDetailsScreenState createState() => _SemesterDetailsScreenState();
}

class _SemesterDetailsScreenState extends StateMVC<SemesterDetailsScreen> {
  String id = '';
  String password = '';
  GradeController _con;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _SemesterDetailsScreenState() : super(GradeController()) {
    _con = controller;
  }

  void getCreds() {
    id = User().getId();
    password = User().getPassword();
  }

  @override
  void initState() {
    super.initState();
    if (GradeController.grade == null || GradeController.grade.isEmpty) {
      _con.getGradeList(widget.sem);
      print('grades reload initiated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: kBackgroundColour,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MumsDrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: RichText(
                        text: TextSpan(
                          text: "Grades",
                          style: TextStyle(
                              color: kFontColour,
                              fontStyle: FontStyle.normal,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              scaffoldKey.currentState.openEndDrawer();
                            },

                            child: Icon(
                              Icons.dehaze,
                              color: kFontColour,
                              size: 30,
                            ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Semester  ${widget.sem}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kSecondaryFontColour,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      (GradeController.grade == null ||
                              GradeController.grade.isEmpty)
                          ? CircularProgressIndicator()
                          : Expanded(
                              child: ListView.builder(
                                itemCount: GradeController.grade.length,
                                itemBuilder: (context, index) {
                                  List<Grade> grades = GradeController.grade;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 14.0),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    width: 4,
                                                    height: 24,
                                                    color: Colors.greenAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${grades[index].subject}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Credits : ',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].credit}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].ta == 0.0 ? '_' : grades[index].ta}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Quiz-1 : ',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].quiz_1 == 0.0 ? '_' : grades[index].quiz_1}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].quiz_2 == 0.0 ? '_' : grades[index].quiz_2}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'MidSem : ',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].midsem == 0.0 ? '_' : grades[index].midsem}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].endsem == 0.0 ? '_' : grades[index].endsem}',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Grade Points : ',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].grade_points == 0.0 ? '_' : grades[index].grade_points}',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            Colors.greenAccent,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${grades[index].grade == '' ? '_' : grades[index].grade}',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            Colors.greenAccent,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                            ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
