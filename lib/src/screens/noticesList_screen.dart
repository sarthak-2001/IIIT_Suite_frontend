import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/notice_controller.dart';
import 'package:iiit_suite/src/models/notices.dart';
import 'package:iiit_suite/src/screens/noticeDetails_screen.dart';
import 'package:iiit_suite/src/widgets/dropDownItems_widget.dart';
import 'package:iiit_suite/src/widgets/noticeList_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:search_page/search_page.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';

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
  _NoticeListScreenState() : super(NoticeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (NoticeController.notices == null || NoticeController.notices.isEmpty) {
      _con.getNoticesList();
      print('notice reload initiated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
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
                                  text: "B418045",
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                showSearch(
                                    context: context,
                                    delegate: SearchPage<Notice>(
                                      items: NoticeController.notices,
                                      searchLabel: 'Search Notice',
                                      suggestion: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            'Search notice by title, content, publisher, date(YYYY-MM-DD)',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      failure: Center(
                                        child: Text('No such notices found'),
                                      ),
                                      filter: (notice) => [
                                        notice.title,
                                        notice.posted_by,
                                        notice.content,
                                        notice.date
                                      ],
                                      barTheme: ThemeData.dark().copyWith(
                                          primaryColor: kBackgroundColour),
                                      builder: (notice) => Container(
                                        color: kForegroundColour,
                                        child: InkWell(
                                          onTap: () {
                                            //TODO: after switching to named routes use pop and pushNamed
                                            Navigator.push(
                                              context,
                                              PageRouteTransition(
                                                maintainState: true,
                                                curves: Curves.easeInCubic,
                                                animationType:
                                                    AnimationType.fade,
                                                builder: (context) =>
                                                    NoticeDetail(
                                                  notice: notice,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 4,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          '${notice.title}'
                                                              .toUpperCase(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15,
                                                              color:
                                                                  kFontColour),
                                                        ),
                                                        Text(
                                                          'BY: ${notice.posted_by}'
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 10,
                                                              color:
                                                                  kFontColour),
                                                        )
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        Text(
                                                          '${notice.date}'
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 13,
                                                              color:
                                                                  kFontColour),
                                                        ),
                                                        Text(
                                                          'to: ${notice.attention}'
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.right,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 10,
                                                              color:
                                                                  kFontColour),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: new BoxDecoration(
                                  color: kForegroundColour,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: kFontColour,
                                  size: 33,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                YudizModalSheet.show(
                                    context: context,
                                    child: IntrinsicHeight(
                                      child: Container(
                                        color: kBottomNavColour,
                                        child: Center(
                                          child: DropDownItems(),
                                        ),
                                      ),
                                    ),
                                    direction: YudizModalSheetDirection.TOP);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: new BoxDecoration(
                                  color: kForegroundColour,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  color: kFontColour,
                                  size: 33,
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
                        child: (NoticeController.notices == null)
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      kBackgroundColour),
                                ),
                              )
                            : NoticeListWidget(con: _con),
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
