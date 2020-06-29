import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/models/books.dart';

Future<List<Book>> getBooks(String string) async {
  List<Book> books = [];
  try {
    Response response = await Dio().post(
        'https://sarthak-mums-iiit.herokuapp.com/booksrch',
        data: {"uid": "b418045", "pwd": "kitu@2001", "search": string});
    for (var n in response.data['books']) {
      books.add(Book(
        id: n['id'],
        name: n['name'],
      ));
    }
    print(books);
    return books;
  } catch (e) {
    print('error in notice repo getbooks()');
    Fluttertoast.showToast(
        msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG);
    return [];
  }
}
