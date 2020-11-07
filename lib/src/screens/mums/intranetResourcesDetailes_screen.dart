import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/bookmark.dart';
import 'package:iiit_suite/src/repository/bookmark_repository.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class IntraNoticeDetail extends StatefulWidget {
  final dynamic notice;
  IntraNoticeDetail({
    @required this.notice,
  });
  @override
  _IntraNoticeDetailState createState() => _IntraNoticeDetailState();
}

class _IntraNoticeDetailState extends State<IntraNoticeDetail> {
  bool isBookmarked;
  @override
  void initState() {
    super.initState();
    BookmarkDao().isPresent(widget.notice.id).then((value) {
      setState(() {
        isBookmarked = value;
      });
    });
//    print(isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MumsDrawerWidget(),
        body: Container(
          color: kForegroundColour,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
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
                              '${widget.notice.title}'.toUpperCase(),
//                                  maxLines: 2,
//                                  overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: kFontColour),
                            ),
                            Text(
                              'BY: ${widget.notice.posted_by}'.toUpperCase(),
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
                              '${widget.notice.date}'.toUpperCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: kFontColour),
                            ),
//                            Text(
//                              'to: ${widget.notice.attention}'.toUpperCase(),
//                              textAlign: TextAlign.right,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w300,
//                                  fontSize: 10,
//                                  color: kFontColour),
//                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: ScrollConfiguration(
                    behavior: BounceScroll(),
                    child: Container(
                      color: Color(0xff0F0C12),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Html(
                            onLinkTap: (url) async {
                              print(url);
                              launch('$url');

//                              if (await canLaunch(url)) {
//                              }

//                              html.window.open(url, 'ho');
//                              html.
//                              await launch(url);
                            },
                            data: """"${widget.notice.content}""",
                            style: {
                              "p": Style(color: kFontColour),
                              "ul": Style(color: kFontColour),
                              "li": Style(color: kFontColour),
                              "h1": Style(color: kFontColour),
                              "h2": Style(color: kFontColour),
                            },
//                          style: TextStyle(fontSize: 14, color: kFontColour),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0xff0F0C12),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.notice.attachment != '')
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 12),
                          child: InkWell(
                            onTap: () async {
                              var status = await Permission.storage.status;
                              if (status.isGranted) {
                                String encodedUrl =
                                    Uri.encodeFull(widget.notice.attachment);
                                await FlutterDownloader.enqueue(
                                  url: encodedUrl,
                                  savedDir: '/storage/emulated/0/Download/',
                                  showNotification:
                                      true, // show download progress in status bar (for Android)
                                  openFileFromNotification:
                                      true, // click on notification to open downloaded file (for Android)
                                );
                                Fluttertoast.showToast(
                                    msg: 'Downloaded',
                                    toastLength: Toast.LENGTH_LONG);
                              } else {
                                await Permission.storage.request();
                              }
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: new BoxDecoration(
                                color: kForegroundColour,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.file_download,
                                color: kFontColour,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: new BoxDecoration(
                              color: kForegroundColour,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: kFontColour,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 12),
                        child: InkWell(
                          onTap: () async {
                            if (isBookmarked == false) {
                              await Provider.of<BookmarkDao>(context).insert(
                                Bookmark(
                                    title: widget.notice.title,
                                    attention: widget.notice.attention,
                                    attachment: widget.notice.attachment,
                                    date: widget.notice.date,
                                    content: widget.notice.content,
                                    posted_by: widget.notice.posted_by,
                                    id_link: widget.notice.id_link,
                                    id: widget.notice.id),
                              );
                              setState(() {
                                isBookmarked = true;
                              });
                              Fluttertoast.showToast(
                                  msg: 'Bookmarked',
                                  toastLength: Toast.LENGTH_SHORT);
                            } else {
                              await Provider.of<BookmarkDao>(context)
                                  .delete(widget.notice.id);
                              setState(() {
                                isBookmarked = false;
                              });
                            }
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: new BoxDecoration(
                              color: kForegroundColour,
                              shape: BoxShape.circle,
                            ),
                            child: isBookmarked == false
                                ? Icon(
                                    Icons.bookmark_border,
                                    color: kFontColour,
                                    size: 25,
                                  )
                                : Icon(
                                    Icons.bookmark,
                                    color: kFontColour,
                                    size: 25,
                                  ),
                          ),
                        ),
                      ),
                    ],
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
