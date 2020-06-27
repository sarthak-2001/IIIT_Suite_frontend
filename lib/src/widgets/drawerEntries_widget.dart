import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';

class DrawerEntries extends StatelessWidget {
  final String title;
  final dynamic route;

  const DrawerEntries({Key key, @required this.title, this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            '$title'.toUpperCase(),
            style: TextStyle(
                color: kFontColour, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
