import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notices {
  String id, password;

  Future<List<Notice>> getNotices() async {
    print('triggeres');
    List<Notice> notices = [];
    try {
      Response response = await Dio().post(
          'https://sarthak-mums-iiit.herokuapp.com/notices',
          data: {"uid": "b418045", "pwd": "kitu@2001"});
      for (var n in response.data) {
        notices.add(Notice(
            attachment: n['attachment'],
            attention: n['attention'],
            date: n['date'],
            id: n['id'],
            id_link: n['id_link'],
            title: n['title'],
            posted_by: n['posted_by'],
            content: n['content']));
      }
      return notices;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    }
  }
}

class Notice {
  final String attention, date, id_link, posted_by, title, content, attachment;
  final int id;

  Notice(
      {this.title,
      this.attachment,
      this.content,
      this.posted_by,
      this.id_link,
      this.attention,
      this.date,
      this.id});
}
