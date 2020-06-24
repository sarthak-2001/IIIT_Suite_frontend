import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/notices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NoticeController extends ControllerMVC {
  List<Notice> notices;
  GlobalKey<ScaffoldState> scaffoldKey;

  NoticeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getNoticesList();
  }

  void getNoticesList() async {
    List<Notice> n = await Notices().getNotices();
    setState(() => notices = n);
    Fluttertoast.showToast(
        msg: 'Notices Updated', toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> refreshNotices() async {
    setState(() {
      notices = [];
    });
    await getNoticesList();
  }
}
