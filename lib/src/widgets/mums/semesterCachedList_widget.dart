import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/semester_controller.dart';
import 'package:iiit_suite/src/helpers.dart';
import 'package:iiit_suite/src/models/sgpa.dart';
import 'package:iiit_suite/src/repository/semester_repository.dart';
import 'package:iiit_suite/src/screens/mums/semesterDetails_screen.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class CachedSemListWidget extends StatelessWidget {
  const CachedSemListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  ' CGPA : ',
                  style: TextStyle(
                      color: kFontColour,
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
                FutureBuilder<String>(
                    future: CgpaDao().getCgpa(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null)
                        return Text(
                          ' _ ',
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        );
                      return Text(
                        ' ${snapshot.data} ',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontStyle: FontStyle.normal,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      );
                    }),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.74,
              child: Divider(
                color: Color(0xffd8caeb),
                thickness: 1.0,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Sgpa>>(
                  future: SemesterDao().getSem(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data.length == 0)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return Column(
                      children: [
                        Container(
                          height: 100,
//                  width: MediaQuery.of(context).size.width,
                          child: Sparkline(
                            data: getPoints(snapshot.data),
                            pointSize: 10.0,
                            pointsMode: PointsMode.all,
                            pointColor: Colors.purple[200],
                            lineWidth: 4,
                            lineGradient: new LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.purple[800], Colors.purple[200]],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: BounceScroll(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                List<Sgpa> sgpa = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SemesterDetailsScreen(
                                                        sem: sgpa[index].sems,
                                                      )));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            color: kForegroundColour,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 4,
                                                        height: 26,
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Semester ${sgpa[index].sems}',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            kSecondaryFontColour,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${sgpa[index].points == '0' ? '_' : sgpa[index].points}',
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
