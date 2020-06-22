import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/notices.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class NoticeDetail extends StatefulWidget {
  final Notice notice;
  NoticeDetail({
    @required this.notice,
  });
  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  @override
  Widget build(BuildContext context) {
    double heightPadding = MediaQuery.of(context).size.height * 0.1;
    double widthPadding = MediaQuery.of(context).size.width * 0.07;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
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
                            Text(
                              'to: ${widget.notice.attention}'.toUpperCase(),
                              textAlign: TextAlign.right,
//                                  maxLines: 2,
//                                  overflow: TextOverflow.ellipsis,
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
                        child: SelectableText(
                          '${widget.notice.content}',
                          style: TextStyle(fontSize: 14, color: kFontColour),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 12),
                        child: InkWell(
                          onTap: () {
                            print('down');
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
                              Icons.arrow_back_ios,
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
                            print('bookmark');
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: new BoxDecoration(
                              color: kForegroundColour,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.bookmark_border,
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
