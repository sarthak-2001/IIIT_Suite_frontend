import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/controllers/semester_controller.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:iiit_suite/src/widgets/mums/semesterCachedList_widget.dart';
import 'package:iiit_suite/src/widgets/mums/semesterList_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../constants.dart';

class GradeScreen extends StatefulWidget {
  @override
  _GradeScreenState createState() => _GradeScreenState();
}

class _GradeScreenState extends StateMVC<GradeScreen> {
  String id = '';
  String password = '';
  SemesterController _con;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _GradeScreenState() : super(SemesterController()) {
    _con = controller;
  }
  void getCreds() {
    id = User().getId();
    password = User().getPassword();
  }

  @override
  void initState() {
    super.initState();
    if (SemesterController.semester == null ||
        SemesterController.semester.sgpa.isEmpty) {
      _con.getSemesterList();
      print('semester reload initiated');
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
            await _con.getSemesterList();
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
                (SemesterController.semester == null ||
                        SemesterController.semester.sgpa.isEmpty)
                    ? CachedSemListWidget()
                    : SemListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
