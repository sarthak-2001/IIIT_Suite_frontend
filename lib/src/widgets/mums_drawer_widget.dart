import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/widgets/drawerItems_mums_widget.dart';

class MumsDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBottomNavColour,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.7,
      child: DrawerItemsMums(),
    );
  }
}
