import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/repository/bookmark_repository.dart';
import 'package:iiit_suite/src/screens/homePages_screen.dart';
import 'package:provider/provider.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  _checkConnection() {
    Connectivity().checkConnectivity().then((connectivityResult) => {
          if (connectivityResult == ConnectivityResult.none)
            {
              Fluttertoast.showToast(
                  msg: 'Connect to Internet', toastLength: Toast.LENGTH_LONG)
            }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _register();
    _checkConnection();
    getMessage();
    _firebaseMessaging.subscribeToTopic("all");
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      Fluttertoast.showToast(
          msg: 'Refresh to Get New Notices', toastLength: Toast.LENGTH_LONG);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => BookmarkDao(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IIIT Suite',
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            hintColor: kFontColour,
            backgroundColor: kForegroundColour,
            scaffoldBackgroundColor: kForegroundColour),
        home: Pages(),
      ),
    );
  }
}
