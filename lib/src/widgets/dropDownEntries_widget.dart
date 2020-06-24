import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';

class DropDownEntries extends StatelessWidget {
  final String title;

  const DropDownEntries({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        '$title'.toUpperCase(),
        style: TextStyle(
            color: kFontColour, fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }
}
