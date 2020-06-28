import 'package:flutter/material.dart';
import 'package:iiit_suite/src/screens/mums/noticeBookmark_screen.dart';
import 'package:iiit_suite/src/screens/mums/noticesList_screen.dart';
import 'package:iiit_suite/src/widgets/drawerEntries_widget.dart';

class DrawerItemsMums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        DrawerEntries(
          title: 'Notice board',
          route: NoticeListScreen(),
        ),
        DrawerEntries(
          title: 'Bookmarks',
          route: NoticeBookmarkScreen(),
        ),
        DrawerEntries(title: 'Student Notice Board'),
        DrawerEntries(title: 'View Grades'),
        DrawerEntries(title: 'View attendance'),
        DrawerEntries(title: 'Student Search'),
        DrawerEntries(title: 'Faculty Search'),
        DrawerEntries(title: 'Library'),
        Divider(
          color: Colors.white24,
          thickness: 1.5,
        ),
        DrawerEntries(title: 'About Developer'),
        DrawerEntries(title: 'Report Bug'),
        DrawerEntries(title: 'Logout'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.009,
        ),
      ],
    );
  }
}
