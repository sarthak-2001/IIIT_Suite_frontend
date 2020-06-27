import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/notices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NoticeController extends ControllerMVC {
  static List<Notice> notices;
  GlobalKey<ScaffoldState> scaffoldKey;

  NoticeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void getNoticesList() async {
    List<Notice> n = await Notices().getNotices();
    setState(() => notices = n);
  }

  Future<void> refreshNotices() async {
    setState(() {
      notices = [];
    });
    await getNoticesList();
  }
}
