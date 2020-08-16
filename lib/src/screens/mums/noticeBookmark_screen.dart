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
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
                          text: "BOOKMARKS",
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
                            // ),
                          ),
                        ),
                      ],
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
                                    child:
//                                    Text(
//                                    'No bookmarks yet!',
//                                    style: TextStyle(color: kFontColour),
//                                  ),
                                        Text(
                                      " 'No Bookmarks Yet' ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: kFontColour),
                                    ),
                                  )
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
