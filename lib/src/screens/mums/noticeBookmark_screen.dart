import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/bookmark.dart';
import 'package:iiit_suite/src/repository/bookmark_repository.dart';
import 'package:iiit_suite/src/widgets/mums/bookmarkList_widget.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:provider/provider.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class NoticeBookmarkScreen extends StatefulWidget {
  @override
  _NoticeBookmarkScreenState createState() => _NoticeBookmarkScreenState();
}

class _NoticeBookmarkScreenState extends State<NoticeBookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          text: "BOOKMARKS",
                          style: TextStyle(
                              color: kFontColour,
                              fontStyle: FontStyle.normal,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<Bookmark>>(
                  stream: Stream.fromFuture(
                      Provider.of<BookmarkDao>(context).getAllSortedByID()),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(color: kForegroundColour),
                            child: (snapshot.data.length == 0)
                                ? Center(
                                    child: Text(
                                    'No bookmarks yet!',
                                    style: TextStyle(color: kFontColour),
                                  ))
                                : BookmarkListWidget(
                                    bookmarks: snapshot.data.reversed.toList(),
                                  ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
