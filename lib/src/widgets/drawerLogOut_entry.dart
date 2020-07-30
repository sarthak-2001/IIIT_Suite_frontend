import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/repository/user_repository.dart';
import 'package:iiit_suite/src/screens/login_screen.dart';

class DrawerLogOutEntry extends StatelessWidget {
  const DrawerLogOutEntry({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);

        await logout();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            'logout'.toUpperCase(),
            style: TextStyle(
                color: kFontColour, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
