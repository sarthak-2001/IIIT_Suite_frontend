import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/repository/user_repository.dart';
import 'package:iiit_suite/src/screens/homePages_screen.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePass = true;
  bool working = false;
  TextEditingController _id = TextEditingController();
  TextEditingController _pass = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
//    check_logged_in();
  }

  @override
  void dispose() {
    _id.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                'TERMS AND CONDITIONS',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[300]),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  border: Border(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text('all the terms here'),
              )
            ],
          ),
        );
      },
    );
  }

  SwipeCallback _onVerticalSwipe(SwipeDirection direction) {
    if (direction == SwipeDirection.up) _showModalSheet();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Container(
//              margin: EdgeInsets.only(top: 40),
              child: Image.asset(
                'assets/logo(1).png',
                height: 300,
                width: 300,
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: width * 0.12,
                  right: width * 0.12,
                  bottom: 50,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryFontColour,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: kForegroundColour,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          validator: (v) {
                            if (v.isEmpty)
                              return 'Can\'t be empty';
                            else
                              return null;
                          },
                          controller: _id,
                          onSaved: (v) => _id,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffc785d2), width: 4.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),

                            suffixIcon: Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.grey[600],
                            ),
                            hintText: 'Hibiscus ID',
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black45),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (v) {
                            if (v.isEmpty)
                              return 'Can\'t be empty';
                            else
                              return null;
                          },
                          controller: _pass,
                          onSaved: (v) => _pass,
                          obscureText: hidePass == true ? true : false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5)),),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffc785d2), width: 4.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  if (hidePass == true)
                                    hidePass = false;
                                  else
                                    hidePass = true;
                                });
                              },
                              child: hidePass == true
                                  ? Icon(
                                      Icons.visibility,
                                      size: 20,
                                      color: Colors.grey[600],
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                            ),
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black45),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      working == false
                          ? Container(
                              child: RaisedButton(
                                color: kBottomNavColour,
                                onPressed: () async {
                                  if (!_key.currentState.validate()) return;

                                  setState(() {
                                    working = true;
                                  });
                                  bool res = await login(_id.text, _pass.text);
                                  _key.currentState.save();
                                  if (res == true) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('id', _id.text);
                                    prefs.setString('password', _pass.text);
                                    User().write(_id.text, _pass.text);

                                    setState(() {
                                      working = false;

                                    });

                                    print('Success');
                                    Fluttertoast.showToast(msg: "Logged In");
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteTransition(
                                            animationType: AnimationType.scale,
                                            builder: (context) => Pages()));
                                  } else {
                                    print('Wrong stuff');
                                    setState(() {
                                      working = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Wrong credentials",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Login to Account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    kForegroundColour),
                              ),
                            ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            Spacer(),
            SimpleGestureDetector(
              onVerticalSwipe: _onVerticalSwipe,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                child: InkWell(
                  onTap: _showModalSheet,
                  child: Container(
                    width: double.infinity,
                    color: kBottomNavColour,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 14),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_up,
                              size: 35, color: kFontColour),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('READ TERMS AND CONDITIONS',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'PTSansNarrow',
                                    color: kFontColour)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
