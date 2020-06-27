import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/screens/its_screen.dart';
import 'package:iiit_suite/src/screens/mess_screen.dart';
import 'package:iiit_suite/src/screens/mums/noticesList_screen.dart';

class Pages extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _curIndex = 0;

  List<Widget> tabs = [NoticeListScreen(), MessScreen(), ITSScreen()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        child: SafeArea(
          child: Scaffold(
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.073,
                color: kBottomNavColour,
                child: BottomNavyBar(
                  selectedIndex: _curIndex,
                  containerHeight: MediaQuery.of(context).size.height * 0.072,
                  showElevation: true,
                  backgroundColor: kBottomNavColour,
                  itemCornerRadius: 100,
                  curve: Curves.easeInCirc,
                  animationDuration: Duration(milliseconds: 200),
                  onItemSelected: (index) {
                    print(index);
                    setState(() {
                      _curIndex = index;
                    });
                  },
                  items: [
                    BottomNavyBarItem(
                      icon: Icon(Icons.home),
                      title: Text('HOME'),
                      activeColor: Colors.white70,
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.restaurant),
                      title: Text('MESS'),
                      activeColor: Colors.white70,
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.swap_vert),
                      title: Text('ITS'),
                      activeColor: Colors.white70,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              body: tabs[_curIndex]),
        ),
      ),
    );
  }
}
