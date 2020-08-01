import 'package:flutter/material.dart';
import 'package:iiit_suite/src/controllers/attendance_controller.dart';
import 'package:iiit_suite/src/models/attendance.dart';

import '../../constants.dart';
import '../attendance_percentage.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class AttendanceListWidget extends StatefulWidget {

  @override
  _AttendanceListWidgetState createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends State<AttendanceListWidget> with SingleTickerProviderStateMixin{
  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressController = AnimationController(duration: Duration(milliseconds: 1000),vsync: this);
    animation = Tween<double>(begin: 0,end: 80).animate(progressController)..addListener((){
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BounceScroll(),
      child: ListView.builder(
        itemCount: AttendanceController.attendance.length,
          itemBuilder: (context,index){
            List<Attendance> attendances =  AttendanceController.attendance;
            return ClipRRect(
              borderRadius:BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.15,
                color: kForegroundColour,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(width: 5,),
                            Text(
                              '${attendances[index].subject}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Attendance :',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${attendances[index].days_present}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),),
                            Text(
                              '${attendances[index].total_days}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Last Updated :',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${attendances[index].last_updated}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),),
                          ],
                        )
                      ],
                    ),
                    CustomPaint(
                      foregroundPainter: CircleProgress(animation.value),
                      child: Container(
                        width: 190,
                        height: MediaQuery.of(context).size.height,
                        child: GestureDetector(
                            onTap: (){
                              if(animation.value == 80){
                                progressController.reverse();
                              }else {
                                progressController.forward();
                              }
                            },
                            child: Center(child: Text("${animation.value.toInt()} %",style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),))),
                      ),
                    )
                  ],
                ),
              ),
            );

          },
      ),
    );
  }
}
