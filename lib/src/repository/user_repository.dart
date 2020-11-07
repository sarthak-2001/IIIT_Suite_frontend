import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/config/api_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String id, String password) async {
  bool result;
  try {
    Response response =
        await Dio().post(user, data: {"uid": id, "pwd": password});
    if (response.data['msg'] == "Welcome")
      result = true;
    else
      result = false;
    return result;
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: 'Unable to reach server', toastLength: Toast.LENGTH_LONG);
    return null;
  }
}

Future<String> getName(String id, String password) async {
  String studentName;
  try {
    Response response =
        await Dio().post(nameRequest, data: {"uid": id, "pwd": password});
//    print(response);
    studentName = response.data['name'];
    studentName = studentName.toString();
    print(studentName);
    return studentName;
  } catch (e) {
    print(e);
//    Fluttertoast.showToast(
//        msg: 'Unable to reach server', toastLength: Toast.LENGTH_LONG);
    return '';
  }
}

Future logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('name');
  await prefs.remove('id');
  await prefs.remove('password');
}

//Future<String> getId() async{
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  String id;
//  id =  prefs.getString('id');
//  return id;
//}
//
//Future<String> getPassword() async{
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  String pass;
//  pass =  prefs.getString('password');
//  return pass;
//}
