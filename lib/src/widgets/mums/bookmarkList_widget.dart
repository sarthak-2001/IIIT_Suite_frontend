import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/bookmark.dart';
import 'package:iiit_suite/src/screens/mums/noticeDetails_screen.dart';
import 'package:route_transitions/route_transitions.dart';

class BookmarkListWidget extends StatelessWidget {
  final List<Bookmark> bookmarks;
  BookmarkListWidget({this.bookmarks});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BounceScroll(),
      child: Scrollbar(
        isAlwaysShown: false,
        child: ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            List<Bookmark> localNotices = bookmarks;
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteTransition(
                        maintainState: true,
                        curves: Curves.easeInCubic,
                        animationType: AnimationType.fade,
                        builder: (context) => NoticeDetail(
                              notice: localNotices[index],
                            )));
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
                              '${localNotices[index].title}'.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: kFontColour),
                            ),
                            Text(
                              'BY: ${localNotices[index].posted_by}'
                                  .toUpperCase(),
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
                              '${localNotices[index].date}'.toUpperCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: kFontColour),
                            ),
                            Text(
                              'to: ${localNotices[index].attention}'
                                  .toUpperCase(),
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
            );
          },
        ),
      ),
    );
  }
}
