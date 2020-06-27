import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/bookmark.dart';
import 'package:iiit_suite/src/models/notice.dart';
import 'package:sembast/sembast.dart';

class BookmarkDao extends ChangeNotifier {
  static const String STORE_NAME = 'bookmark';
  final _bookmarkStore = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;
  Future insert(Bookmark notice) async {
    await _bookmarkStore.add(await _db, notice.toMap());
    notifyListeners();
  }

  Future delete(int ID) async {
    final finder = Finder(filter: Filter.equals('id', ID));
    await _bookmarkStore.delete(
      await _db,
      finder: finder,
    );
    notifyListeners();
  }

  Future<List<Bookmark>> getAllSortedByID() async {
    var finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshots = await _bookmarkStore.find(
      await _db,
      finder: finder,
    );
    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final notice = Bookmark.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      notice.db_id = snapshot.key;
      return notice;
    }).toList();
    notifyListeners();
  }

  Future<bool> isPresent(int ID) async {
    final finder = Finder(filter: Filter.equals('id', ID));
    try {
      final recordSnapshots = await _bookmarkStore.findFirst(
        await _db,
        finder: finder,
      );
      final notice = Bookmark.fromMap(recordSnapshots.value);
      return true;
    } catch (e) {
      return false;
    }
//    return notice;
  }
}

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
    return [];
  }
}
