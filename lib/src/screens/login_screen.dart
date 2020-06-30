import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/repository/user_repository.dart';
import 'package:iiit_suite/src/screens/homePages_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    check_logged_in();
  }

  @override
  void dispose() {
    _id.dispose();
    _pass.dispose();
    super.dispose();
  }

  void check_logged_in() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    String id = loginData.getString('id');
    if (id != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Pages()));
    }
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColour,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              'IIIT SUITE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: height * 0.3,
                  left: width * 0.12,
                  right: width * 0.12,
                  bottom: height * 0.28),
              decoration: BoxDecoration(
                color: kFontColour,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
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
                        obscureText: hidePass == true ? true : false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
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
                              color: kForegroundColour,
                              onPressed: () async {
                                if (!_key.currentState.validate()) return;

                                setState(() {
                                  working = true;
                                });
                                bool res = await login(_id.text, _pass.text);
                                if (res == true) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('id', _id.text);
                                  prefs.setString('password', _pass.text);

                                  setState(() {
                                    working = false;
                                  });

                                  print('Success');
                                  Fluttertoast.showToast(msg: "Logged In");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: InkWell(
                onTap: _showModalSheet,
                child: Container(
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
    );
  }
}
