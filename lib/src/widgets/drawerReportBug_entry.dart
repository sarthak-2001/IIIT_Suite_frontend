import 'package:flutter/material.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerReportBugEntry extends StatelessWidget {
  const DrawerReportBugEntry({Key key,}) : super(key: key);

  Future<void> _launchEmail() async{
    var url = "mailto:b318013@iiit-bh.ac.in,b418045@iiit-bh.ac.in?subject= IIIT Suite Report Bug ";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Could not send email to Recieptant';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _launchEmail();
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            'Report Bug'.toUpperCase(),
            style: TextStyle(
                color: kFontColour, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}