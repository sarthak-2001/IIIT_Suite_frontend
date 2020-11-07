import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/intraNotice_controller.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:iiit_suite/src/widgets/mums/noticeList_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class IntraNoticeListScreen extends StatefulWidget {
  IntraNoticeListScreen({Key key}) : super(key: key);

  @override
  _IntraNoticeListScreenState createState() => _IntraNoticeListScreenState();
}

class _IntraNoticeListScreenState extends StateMVC<IntraNoticeListScreen> {
  IntraNoticeController _con;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _IntraNoticeListScreenState() : super(IntraNoticeController()) {
    _con = controller;
  }

  String id = '';

  void getId() {
    id = User().getId();
  }

  @override
  void initState() {
    super.initState();
    getId();
    if (IntraNoticeController.notices == null ||
        IntraNoticeController.notices.isEmpty) {
      _con.getNoticesList();
      print('notice reload initiated');
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacementNamed(context, '/home');
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: kBackgroundColour,
          endDrawerEnableOpenDragGesture: true,
          endDrawer: MumsDrawerWidget(),
          body: RefreshIndicator(
            onRefresh: _con.refreshNotices,
            child: Padding(
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
                              text: "Intranet Resources",
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
                              ),
                            ),
                            // ),
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
                          child: (IntraNoticeController.notices == null)
                              ? Center(
                                  child: SpinKitFadingGrid(
                                    color: Colors.white70,
                                  ),
                                )
                              : NoticeListWidget(con: 0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
