import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';

class ITSScreen extends StatefulWidget {
  @override
  _ITSScreenState createState() => _ITSScreenState();
}

class _ITSScreenState extends State<ITSScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        body: Center(
          child: Text(
            'Coming Soon',
            style: TextStyle(fontSize: 30, color: Color(0xffffffff)),
          ),
        ),
      ),
    );
  }
}
