import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/student.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/repository/student_repository.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class StudentSearchScreen extends StatefulWidget {
  StudentSearchScreen({Key key}) : super(key: key);

  @override
  _StudentSearchScreenState createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  String id = '';
  String password = '';
  bool loading = false;
  List<Student> students = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  void getCreds() {
    id = User().getId();
    password = User().getPassword();
  }

  void _showDialog(Student student) async {
    String url =
        'https://hib.iiit-bh.ac.in/m-ums-2.0/assets/clientdata/iiit/Photos/${student.id}.jpg';
//    String url = await getStudentImage(student.link);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "${student.id}",
            textAlign: TextAlign.center,
          ),
          content: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => Icon(
              Icons.person,
              size: 70,
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              size: 70,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCreds();
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
          padding: const EdgeInsets.fromLTRB(21.0, 12, 21, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: RichText(
                        text: TextSpan(
                          text: "Student Search",
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
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                color: kForegroundColour,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.dehaze,
                                color: kFontColour,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        decoration: BoxDecoration(color: kForegroundColour),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      textInputAction: TextInputAction.search,
                                      controller: _controller,
                                      enableSuggestions: true,
                                      onEditingComplete: () async {
                                        SystemChannels.textInput
                                            .invokeListMethod('TextInput.hide');
                                        setState(() {
                                          loading = true;
                                        });
                                        List<Student> mock =
                                            await getStudents(_controller.text);
                                        setState(() {
                                          students = mock;
                                          loading = false;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            SystemChannels.textInput
                                                .invokeListMethod(
                                                    'TextInput.hide');
                                            setState(() {
                                              loading = true;
                                            });
                                            List<Student> mock =
                                                await getStudents(
                                                    _controller.text);
                                            setState(() {
                                              students = mock;
                                              loading = false;
                                            });
                                          },
                                          child: loading == false
                                              ? Icon(Icons.search)
                                              : Container(
                                                  child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.red,
                                child: students.length == 0
                                    ? Center(
                                        child: Text('Search by name and id'),
                                      )
                                    : ScrollConfiguration(
                                        behavior: BounceScroll(),
                                        child: ListView.builder(
                                            itemCount: students.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  print('tap');
                                                  _showDialog(students[index]);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(students[index].id),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          students[index].name),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                              ),
                            )
                          ],
                        )),
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
