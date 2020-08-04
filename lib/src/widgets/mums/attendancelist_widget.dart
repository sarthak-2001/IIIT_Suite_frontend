import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iiit_suite/src/controllers/attendance_controller.dart';
import 'package:iiit_suite/src/models/attendance.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class AttendanceListWidget extends StatefulWidget {
  @override
  _AttendanceListWidgetState createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends State<AttendanceListWidget> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BounceScroll(),
      child: AttendanceController.attendance == null
          ? Center(
              child: SpinKitFadingGrid(color: Colors.white70),
            )
          : ListView.builder(
              itemCount: AttendanceController.attendance.length,
              itemBuilder: (context, index) {
                List<Attendance> attendances = AttendanceController.attendance;
                return Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        color: kForegroundColour,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                Text(
                                  '${attendances[index].subject}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Attendance : ',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${attendances[index].days_present}/',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${attendances[index].total_days}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Last Updated : ',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${attendances[index].last_updated}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                IntrinsicHeight(
                                  child: CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: (attendances[index].days_present /
                                        attendances[index].total_days),
                                    center: new Text(
                                      '${((attendances[index].days_present / attendances[index].total_days) * 100).toStringAsPrecision(3)}%',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.greenAccent,
                                    backgroundColor: Colors.black45,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
    );
  }
}
