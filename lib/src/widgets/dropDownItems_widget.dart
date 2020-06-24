import 'package:flutter/material.dart';
import 'package:iiit_suite/src/widgets/dropDownEntries_widget.dart';

class DropDownItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        DropDownEntries(title: 'Notice board'),
        DropDownEntries(title: 'View Grades'),
        DropDownEntries(title: 'View attendance'),
        DropDownEntries(title: 'Student Search'),
        DropDownEntries(title: 'Faculty Search'),
        DropDownEntries(title: 'Library'),
        DropDownEntries(title: 'Student Notice Board'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }
}
