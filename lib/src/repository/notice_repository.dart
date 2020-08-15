import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/notice.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/widgets/api_request.dart';
import 'package:sembast/sembast.dart';

class NoticeDao {
  static const String STORE_NAME = 'notice';
  final _noticeStore = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Notice notice) async {
    final finder = Finder(filter: Filter.equals('id', notice.id));
    var isUpdated =
        await _noticeStore.update(await _db, notice.toMap(), finder: finder);
    if (isUpdated == 0) {
      await _noticeStore.add(await _db, notice.toMap());
    }
  }

  Future<List<Notice>> getAllSortedByID() async {
    var finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshots = await _noticeStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final notice = Notice.fromMap(snapshot.value);
      notice.db_id = snapshot.key;
      return notice;
    }).toList();
  }

  Future deleteDB() async {
    await _noticeStore.drop(await _db);
  }
}

Future<List<Notice>> getNotices() async {
  String id = User().getId();
  String password = User().getPassword();
  print('triggeres');
  List<Notice> notices = [];
  try {
    Response response = await Dio().post(
        notice,
        data: {"uid": id, "pwd": password});
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

      NoticeDao().insert(Notice(
          attachment: n['attachment'],
          attention: n['attention'],
          date: n['date'],
          id: n['id'],
          id_link: n['id_link'],
          title: n['title'],
          posted_by: n['posted_by'],
          content: n['content']));
    }
    //
//    await NoticeDao().deleteDB();
    //
    print('fetched notices');
    return notices;
  } catch (e) {
    print('error in notice repo getNoticces()');
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}
