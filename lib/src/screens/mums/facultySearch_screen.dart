import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/faculty_controller.dart';
import 'package:iiit_suite/src/models/faculty.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/repository/faculty_repository.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../constants.dart';
import '../../constants.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class FacultySearchScreen extends StatefulWidget {
  FacultySearchScreen({Key key}) : super(key: key);

  @override
  _FacultySearchScreenState createState() => _FacultySearchScreenState();
}

class _FacultySearchScreenState extends StateMVC<FacultySearchScreen> {
  FacultyController _con;

  _FacultySearchScreenState() : super(FacultyController()) {
    _con = controller;
  }
  String id = '';
  String password = '';
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();

  void getCreds() {
    id = User().getId();
    password = User().getPassword();
  }

  var items = List<Faculty>();

  void _showDialog(Faculty faculty) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15.0)),
          backgroundColor: kForegroundColour,

          title: new Text(
            "${faculty.name}",
            style: TextStyle(
              color: Color(0xffEDE7F6)
            ),
            textAlign: TextAlign.center,
          ),
          content: FutureBuilder<String>(
              future: getFacultyImage(faculty.link),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CachedNetworkImage(
                        imageUrl: snapshot.data,
                        placeholder: (context, url) => Icon(
                          Icons.person,
                          size: 70,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          size: 70,
                        ),
                      )
                    : SpinKitFadingGrid(color: Colors.white70);
              }),

          actions: <Widget>[
            new RaisedButton(
              elevation: 5.0,
              child: new Text("Close"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
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
    if (FacultyController.faculties == null || FacultyController.faculties.isEmpty) _con.getFacultyList();

    items.addAll(FacultyController.faculties ?? []);
  }

  //Logic to search custom objects

  void filterSearchResults(String query) {
    List<Faculty> dummySearchList = List<Faculty>();
    dummySearchList.addAll(FacultyController.faculties);
    if (query.isNotEmpty) {
      List<Faculty> dummyListData = List<Faculty>();
      dummySearchList.forEach((item) {
        if (item.dept.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        } else if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        print(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(FacultyController.faculties);
      });
    }
  }

  //UI starts here

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
                          text: "Faculty Search",
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
                            /*child: Container(
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                color: kForegroundColour,
                                shape: BoxShape.circle,
                              ),*/
                              child: Icon(
                                Icons.dehaze,
                                color: kFontColour,
                                size: 30,
                              ),
                            //),
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
                                    onChanged: (value) async {
                                      filterSearchResults(value);
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      suffixIcon: Icon(Icons.search,color: kFontColour,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: _controller.text == ''
                                ? Container(
                                    color: kForegroundColour,
                                    child: FacultyController.faculties == null || FacultyController.faculties.length == 0
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ScrollConfiguration(
                                            behavior: BounceScroll(),
                                            child: ListView.builder(
                                              itemCount: FacultyController.faculties.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    print('tappp');
                                                    _showDialog(
                                                        FacultyController.faculties[index]);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(FacultyController.faculties[index].name,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xffEDE7F6),
                                                            fontSize:15
                                                          ),),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        IntrinsicHeight(
                                                          child: Text(
                                                              FacultyController
                                                                  .faculties[
                                                                      index]
                                                                  .dept,
                                                              style: TextStyle(
                                                              fontWeight: FontWeight.w200,
                                                              color: Color(0xffE1BEE7),
                                                              fontSize:12
                                                          ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  )
                                : Container(
                                    color: Colors.white70,
                                    child: items.isEmpty
                                        ? Center(
                                            child: Text(" 'No result' ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700
                                            ),),
                                          )
                                        : ListView.builder(
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  print('tap');
                                                  _showDialog(items[index]);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        items[index].name,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize:15
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      IntrinsicHeight(
                                                        child: Text(
                                                            items[index].dept,
                                                            style: TextStyle(
                                                            fontWeight: FontWeight.w200,
                                                            fontSize:12
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                          )
                        ],
                      ),
                    ),
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
