import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/notice_controller.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/mums/cachedNoticelist_widget.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:iiit_suite/src/widgets/mums/noticeList_widget.dart';
import 'package:iiit_suite/src/widgets/mums/noticeSearch_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class NoticeListScreen extends StatefulWidget {
  NoticeListScreen({Key key}) : super(key: key);

  @override
  _NoticeListScreenState createState() => _NoticeListScreenState();
}

class _NoticeListScreenState extends StateMVC<NoticeListScreen> {
  NoticeController _con;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _NoticeListScreenState() : super(NoticeController()) {
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
    if (NoticeController.notices == null || NoticeController.notices.isEmpty) {
      _con.getNoticesList();
      print('notice reload initiated');
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
                            text: "HELLO\n",
                            style: TextStyle(
                                color: kFontColour,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "$id",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      height: 1,
                                      color: kFontColour,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w800))
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          noticeSearchWidget(),
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
                        child: (NoticeController.notices == null)
                            ? CachedNoticeListWidget()
                            : NoticeListWidget(con: 1),
                      ),
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
