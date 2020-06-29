import 'package:flutter/material.dart';
import 'package:iiit_suite/src/config/app_database.dart';
import 'package:iiit_suite/src/models/bookmark.dart';
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
    return recordSnapshots.map((snapshot) {
      final notice = Bookmark.fromMap(snapshot.value);
      notice.db_id = snapshot.key;
      return notice;
    }).toList();
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
  }
}
