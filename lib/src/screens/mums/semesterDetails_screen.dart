import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/controllers/grades_controller.dart';
import 'package:iiit_suite/src/models/grades.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/repository/grade_repository.dart';
import 'package:iiit_suite/src/widgets/mums/cachedGradeList_widget.dart';
import 'package:iiit_suite/src/widgets/mums/gradeList_widget.dart';
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
    GradeController.noData = false;
    if (GradeController.grade == null ||
        GradeController.grade.isEmpty ||
        GradeController.grade[0].semester.toString() != widget.sem) {
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
        body: RefreshIndicator(
          onRefresh: () async {
            await _con.getGradeList(widget.sem);
          },
          child: Padding(
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
//                    mainAxisAlignment: MainAxisAlignment.center,
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
                            ? CachedGradeListWidget(
                                sem: int.parse(widget.sem),
                              )
                            : GradeListWidget(),
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
      ),
    );
  }
}
