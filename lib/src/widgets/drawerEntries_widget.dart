import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';

class DrawerEntries extends StatelessWidget {
  final String title;

  const DrawerEntries({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$title'.toUpperCase(),
        style: TextStyle(
            color: kFontColour, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
