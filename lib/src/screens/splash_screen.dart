import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/screens/homePages_screen.dart';
import 'package:iiit_suite/src/screens/login_screen.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2300), () {});
    return true;
  }

  void check_logged_in() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    String id = loginData.getString('id');
    String password = loginData.getString('password');
    if (id != null) {
      User().write(id, password);
      Navigator.pushReplacement(
          context,
          PageRouteTransition(
              animationType: AnimationType.scale,
              builder: (context) => Pages()));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteTransition(
              animationType: AnimationType.scale,
              builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((value) => check_logged_in());
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: 0.0.tweenTo(60.0),
      duration: 2.seconds,
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return SafeArea(
          child: Center(
            child: Text(
              'IIIT Suite',
              style: TextStyle(fontSize: value, color: Colors.white24),
            ),
          ),
        );
      },
    );
  }
}
