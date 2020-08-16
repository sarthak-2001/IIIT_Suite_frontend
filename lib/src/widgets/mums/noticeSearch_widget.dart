import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/controllers/notice_controller.dart';
import 'package:iiit_suite/src/models/notice.dart';
import 'package:iiit_suite/src/screens/mums/noticeDetails_screen.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:search_page/search_page.dart';

class noticeSearchWidget extends StatelessWidget {
  const noticeSearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      " 'Search notices by title, content, publisher, date(YYYY-MM-DD)' ",
                      style: TextStyle(
                          color: kFontColour,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                failure: Center(
                  child: Text(
                    " 'No Notice' ",
                    style: TextStyle(
                        color: kFontColour,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                filter: (notice) => [
                  notice.title,
                  notice.posted_by,
                  notice.content,
                  notice.date
                ],
                barTheme:
                    ThemeData.dark().copyWith(primaryColor: kBackgroundColour),
                builder: (notice) => Container(
                  color: kForegroundColour,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteTransition(
                          maintainState: true,
                          curves: Curves.easeInCubic,
                          animationType: AnimationType.fade,
                          builder: (context) => NoticeDetail(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${notice.title}'.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: kFontColour),
                                  ),
                                  Text(
                                    'BY: ${notice.posted_by}'.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10,
                                        color: kFontColour),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '${notice.date}'.toUpperCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                        color: kFontColour),
                                  ),
                                  Text(
                                    'to: ${notice.attention}'.toUpperCase(),
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10,
                                        color: kFontColour),
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
        /*child: Container(
          height: 40,
          width: 40,
          decoration: new BoxDecoration(
            color: kForegroundColour,
            shape: BoxShape.circle,
          ),*/
        child: Icon(
          Icons.search,
          color: kFontColour,
          size: 30,
        ),
        //),
      ),
    );
  }
}
