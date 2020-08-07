import 'package:flutter/material.dart';
import 'package:iiit_suite/src/screens/api_screen.dart';
import 'package:iiit_suite/src/screens/devlopers_screen.dart';
import 'package:iiit_suite/src/screens/mums/attendance_screen.dart';
import 'package:iiit_suite/src/screens/mums/bookSearch_screen.dart';
import 'package:iiit_suite/src/screens/mums/facultySearch_screen.dart';
import 'package:iiit_suite/src/screens/mums/semester_screen.dart';
import 'package:iiit_suite/src/screens/mums/intranetResources_screen.dart';
import 'package:iiit_suite/src/screens/mums/noticeBookmark_screen.dart';
import 'package:iiit_suite/src/screens/mums/noticesList_screen.dart';
import 'package:iiit_suite/src/screens/mums/privacyPolicy_screen.dart';
import 'package:iiit_suite/src/screens/mums/semesterDetails_screen.dart';
import 'package:iiit_suite/src/screens/mums/studentSearch_screen.dart';
import 'package:iiit_suite/src/widgets/drawerEntries_widget.dart';
import 'package:iiit_suite/src/widgets/drawerLogOut_entry.dart';
import 'package:iiit_suite/src/widgets/drawerReportBug_entry.dart';

class DrawerItemsMums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          DrawerEntries(
            title: 'Intranet Resources',
            route: IntraNoticeListScreen(),
          ),
          DrawerEntries(
            title: 'Test board',
            route: Testing(),
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
          DrawerEntries(
            title: 'View Grades',
            route: GradeScreen(),
            //route: SemesterDetailsScreen(),
          ),
          DrawerEntries(
            title: 'View attendance',
            route: AttendanceScreen(),
          ),
          DrawerEntries(
            title: 'Student Search',
            route: StudentSearchScreen(),
          ),
          DrawerEntries(
            title: 'Faculty Search',
            route: FacultySearchScreen(),
          ),
          DrawerEntries(
            title: 'Book Search',
            route: BookSearchScreen(),
          ),
          Divider(
            color: Colors.white24,
            thickness: 1.5,
          ),
          DrawerEntries(
              title: 'About Developer',
              route:DeveloperScreen(),
          ),
          DrawerEntries(
            title: 'Privacy Policy',
            route: PrivacyPolicyScreeen(),
          ),
          DrawerReportBugEntry(),
          DrawerLogOutEntry(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.009,
          ),
        ],
      ),
    );
  }
}
