import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}


class DeveloperScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _launched;

  static var email;

  Future<void> _launchGithubInBrowser(String url )async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchLinkdeinLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _launchEmail(String emailId) async{
    var url = "mailto:$emailId?subject= IIIT Suite Query ";
    if(await canLaunch(url)){
     await launch(url);
    }
    else{
      throw 'Could not send email to $emailId';
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: kBackgroundColour,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MumsDrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: RichText(
                        text: TextSpan(
                          text: "About Developer",
                          style: TextStyle(
                              color: kFontColour,
                              fontStyle: FontStyle.normal,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              scaffoldKey.currentState.openEndDrawer();
                            },

                            child: Icon(
                              Icons.dehaze,
                              color: kFontColour,
                              size: 30,
                            ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ScrollConfiguration(
                    behavior: BounceScroll(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Developers',
                            style: TextStyle(
                                color: kSecondaryFontColour,
                                fontSize:22,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: Divider(
                              color: Color(0xffd8caeb),
                              thickness: 1.0,
                            ),
                          ),
                          SizedBox(height: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: IntrinsicHeight(
                              child: Container(

                                padding: EdgeInsets.all(10),
                                color: kForegroundColour,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 55,
                                          backgroundImage: AssetImage('assets/logo.png'),
                                        ),
                                        SizedBox(width: 25,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Divyajyoti Dash',
                                              style: TextStyle(
                                                  color: Color(0xffE1BEE7),
                                                  fontSize:20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Text(
                                              'B318013',
                                              style: TextStyle(
                                                  color: kSecondaryFontColour,
                                                  fontSize:14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            _launchGithubInBrowser('https://github.com/dj999dash');

                                          },
                                            icon: FaIcon(FontAwesomeIcons.github,size: 35,color: kFontColour,),
                                            ),
                                        IconButton(
                                          onPressed: (){
                                            _launchLinkdeinLinkIos('https://www.linkedin.com/in/divyajyoti-dash-0aaa42192');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.linkedin,size: 35,color: kFontColour),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchEmail('b318013@iiit-suite-bh.ac.in');
                                          },
                                          icon: FaIcon(FontAwesomeIcons.solidEnvelope,size: 35,color: kFontColour),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: IntrinsicHeight(
                              child: Container(

                                padding: EdgeInsets.all(10),
                                color: kForegroundColour,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 55,
                                          backgroundImage: AssetImage('assets/sarthak.jpg'),
                                        ),
                                        SizedBox(width: 25,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Sarthak Brahma',
                                              style: TextStyle(
                                                  color: Color(0xffE1BEE7),
                                                  fontSize:20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Text(
                                              'B418045',
                                              style: TextStyle(
                                                  color: kSecondaryFontColour,
                                                  fontSize:14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            _launchGithubInBrowser('https://github.com/sarthak-2001');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.github,size: 35,color: kFontColour,),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchLinkdeinLinkIos('https://www.linkedin.com/in/sarthak-brahma-4b3458150');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.linkedin,size: 35,color: kFontColour),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchEmail('b418045@iiit-suite-bh.ac.in');
                                          },
                                          icon: FaIcon(FontAwesomeIcons.solidEnvelope,size: 35,color: kFontColour),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 22,),
                          Text('Contributors',
                            style: TextStyle(
                                color: kSecondaryFontColour,
                                fontSize:22,
                                fontWeight: FontWeight.bold,
                            ),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: Divider(
                              color: Color(0xffd8caeb),
                              thickness: 1.0,
                            ),
                          ),
                          SizedBox(height: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: IntrinsicHeight(
                              child: Container(

                                padding: EdgeInsets.all(10),
                                color: kForegroundColour,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 55,
                                          backgroundImage: AssetImage('assets/logo.png'),
                                        ),
                                        SizedBox(width: 25,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Barbie Shah',
                                              style: TextStyle(
                                                  color: Color(0xffE1BEE7),
                                                  fontSize:20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Text(
                                              'B418018',
                                              style: TextStyle(
                                                  color: kSecondaryFontColour,
                                                  fontSize:14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            _launchLinkdeinLinkIos('');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.linkedin,size: 35,color: kFontColour),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchEmail('b418018@iiit-suite-bh.ac.in');
                                          },
                                          icon: FaIcon(FontAwesomeIcons.solidEnvelope,size: 35,color: kFontColour),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: IntrinsicHeight(
                              child: Container(

                                padding: EdgeInsets.all(10),
                                color: kForegroundColour,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 55,
                                          backgroundImage: AssetImage('assets/logo.png'),
                                        ),
                                        SizedBox(width: 25,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Pranshu Kumbhare',
                                              style: TextStyle(
                                                  color: Color(0xffE1BEE7),
                                                  fontSize:20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Text(
                                              'B218030',
                                              style: TextStyle(
                                                  color: kSecondaryFontColour,
                                                  fontSize:14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            _launchGithubInBrowser('');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.github,size: 35,color: kFontColour,),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchLinkdeinLinkIos('');

                                          },
                                          icon: FaIcon(FontAwesomeIcons.linkedin,size: 35,color: kFontColour),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _launchEmail('b218030@iiit-suite-bh.ac.in');
                                          },
                                          icon: FaIcon(FontAwesomeIcons.solidEnvelope,size: 35,color: kFontColour),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
