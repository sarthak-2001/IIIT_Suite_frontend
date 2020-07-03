import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/notice.dart';
import 'package:iiit_suite/src/repository/intranetResources_repository.dart'
    as Repo;
import 'package:mvc_pattern/mvc_pattern.dart';

class IntraNoticeController extends ControllerMVC {
  static List<Notice> notices;
  GlobalKey<ScaffoldState> scaffoldKey;

  IntraNoticeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void getNoticesList() async {
    List<Notice> n = await Repo.getNotices();
    setState(() => notices = n);
  }

  Future<void> refreshNotices() async {
    setState(() {
      notices = [];
    });
    await getNoticesList();
  }
}
