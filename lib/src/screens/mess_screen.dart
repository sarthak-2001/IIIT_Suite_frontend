import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';

class MessScreen extends StatefulWidget {
  @override
  _MessScreenState createState() => _MessScreenState();
}

class _MessScreenState extends State<MessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        body: Center(
          child: Text(
            'Mess',
            style: TextStyle(fontSize: 30, color: Color(0xffffffff)),
          ),
        ),
      ),
    );
  }
}
