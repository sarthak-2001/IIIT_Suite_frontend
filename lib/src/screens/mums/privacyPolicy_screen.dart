import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';

import '../../constants.dart';

class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class PrivacyPolicyScreeen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: kBackgroundColour,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MumsDrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(21.0, 12, 21, 12),
          child: Column(
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: RichText(
                        text: TextSpan(
                          text: "Privacy Policy",
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
                    child: Scrollbar(
                      controller: controller,
                      isAlwaysShown: true,
                      radius: Radius.circular(50),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'IIIT-Suite ("us", "we", or "our") operates the IIIT-Suite mobile application (the "Service").',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'This page informs you of our policies regarding the collection, use, and disclosure of personal'
                              ' data when you use our Service and the choices you have associated with that data. '
                              'Our Privacy Policy for IIIT-Suite is managed through Free Privacy Policy.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'We use your data to provide and improve the Service. By using the Service,'
                              ' you agree to the collection and use of information in accordance with this policy.'
                              ' Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Information Collection And Use',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'We collect several different types of information for various purposes to provide and improve our Service to you.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Types of Data Collected',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Personal Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'While using our Service, we may ask you to provide us with certain personally identifiable information that'
                              ' can be used to contact or identify you ("Personal Data"). Personally identifiable information may include,'
                              ' but is not limited to:',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '1. Email address',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '2. Cookies and Usage Data',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Usage Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'When you access the Service by or through a mobile device, we may collect certain information automatically, including,'
                              ' but not limited to, the type of mobile device you use, your mobile device unique ID, the IP address of your mobile device,'
                              ' your mobile operating system, the type of mobile Internet browser you use,'
                              ' unique device identifiers and other diagnostic data ("Usage Data").',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Tracking & Cookies Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'We use cookies and similar tracking technologies to track the activity on our Service and hold certain information.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Cookies are files with small amount of data which may include an anonymous unique identifier. Cookies are sent to your'
                              ' browser from a website and stored on your device. Tracking technologies also used are beacons, tags, and scripts to'
                              ' collect and track information and to improve and analyze our Service.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.'
                              ' However, if you do not accept cookies, you may not be able to use some portions of our Service.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Examples of Cookies we use:',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '1. Session Cookies. We use Session Cookies to operate our Service.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '2. Preference Cookies. We use Preference Cookies to remember your preferences and various settings.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '3. Security Cookies. We use Security Cookies for security purposes.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Use of Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'IIIT-Suite uses the collected data for various purposes:',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '1. To provide and maintain the Service',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '2. To notify you about changes to our Service',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '3. To allow you to participate in interactive features of our Service when you choose to do so',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '4. To provide customer care and support',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '5. To provide analysis or valuable information so that we can improve the Service',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '6. To monitor the usage of the Service',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '7. To detect, prevent and address technical issues',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Tranfer of Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Your information, including Personal Data, may be transferred to — and maintained on — computers located'
                              ' outside of your state, province, country or other governmental jurisdiction where the data protection'
                              ' laws may differ than those from your jurisdiction.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'If you are located outside India and choose to provide information to us, please note that we transfer the data,'
                              ' including Personal Data, to India and process it there.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'IIIT-Suite will take all steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of your data and other personal information.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Disclosure of Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Types of Data Collected',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'IIIT-Suite may disclose your Personal Data in the good faith belief that such action is necessary to:',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1. To comply with a legal obligation',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '2. To protect and defend the rights or property of IIIT-Suite',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '3. To prevent or investigate possible wrongdoing in connection with the Service',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '4. To protect the personal safety of users of the Service or the public',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '5. To protect against legal liability',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Security of Data',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'The security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means'
                              ' to protect your Personal Data,'
                              ' we cannot guarantee its absolute security.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Links To Other Sites',
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Our Service may contain links to other sites that are not operated by us. If you click on a third party link, you will be directed to that third partys site'
                              'We strongly advise you to review the Privacy Policy of every site you visit.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Children's Privacy",
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Our Service does not address anyone under the age of 18 ("Children").',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "We do not knowingly collect personally identifiable information from anyone under the age of 18."
                              " If you are a parent or guardian and you are aware that your Children has provided us with Personal Data,"
                              " please contact us. If we become aware that we have collected Personal Data from children without verification of parental consent,"
                              " we take steps to remove that information from our servers.",
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Changes To This Privacy Policy",
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.",
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and'
                              ' update the "effective date" at the top of this Privacy Policy.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'You are advised to review this Privacy Policy periodically for any changes.'
                              ' Changes to this Privacy Policy are effective when they are posted on this page.',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Changes To This Privacy Policy",
                              style: TextStyle(
                                  color: Color(0xffE1BEE7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'If you have any questions about this Privacy Policy, please contact us:',
                              style: TextStyle(
                                  color: kSecondaryFontColour,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'By Email: ',
                                  style: TextStyle(
                                      color: kSecondaryFontColour,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  ' b318013@iiit-bh.ac.in',
                                  style: TextStyle(
                                      color: Color(0xffE1BEE7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'By Email: ',
                                  style: TextStyle(
                                      color: kSecondaryFontColour,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  ' b418045@iiit-bh.ac.in',
                                  style: TextStyle(
                                      color: Color(0xffE1BEE7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
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
