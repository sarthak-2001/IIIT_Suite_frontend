import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iiit_suite/src/constants.dart';
import 'package:iiit_suite/src/models/books.dart';
import 'package:iiit_suite/src/models/user.dart';
import 'package:iiit_suite/src/repository/book_repository.dart';
import 'package:iiit_suite/src/widgets/mums/mums_drawer_widget.dart';

import '../../constants.dart';


class BounceScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      BouncingScrollPhysics();
}

class BookSearchScreen extends StatefulWidget {
  BookSearchScreen({Key key}) : super(key: key);

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  String id = '';
  String password = '';
  bool loading = false;
  List<Book> books = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  void getCreds() {
    id = User().getId();
    password = User().getPassword();
  }

  @override
  void initState() {
    super.initState();
    getCreds();
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
          padding: const EdgeInsets.fromLTRB(21.0, 12, 21, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: RichText(
                        text: TextSpan(
                          text: "Book Search",
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
                            /*child: Container(
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                color: kForegroundColour,
                                shape: BoxShape.circle,
                              ),*/
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        decoration: BoxDecoration(color: kForegroundColour),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      style: TextStyle(color: Color(0xffF5F5F5)),
                                      textInputAction: TextInputAction.search,
                                      controller: _controller,
                                      enableSuggestions: true,
                                      onEditingComplete: () async {
                                        SystemChannels.textInput
                                            .invokeListMethod('TextInput.hide');
                                        setState(() {
                                          loading = true;
                                        });
                                        List<Book> mock = await getBooks(_controller.text);
                                        setState(() {
                                          books = mock;
                                          loading = false;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white)
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            SystemChannels.textInput
                                                .invokeListMethod('TextInput.hide');
                                            setState(() {
                                              loading = true;
                                            });
                                            List<Book> mock = await getBooks(
                                                _controller.text);
                                            setState(() {
                                              books = mock;
                                              loading = false;
                                            });
                                          },
                                          child: loading == false
                                              ? Icon(Icons.search,color: Colors.white,)
                                              : Container(
                                                  child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                  CircularProgressIndicator(backgroundColor: Colors.white70,),
                                                )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                color: kForegroundColour,
                                child: books.length == 0
                                    ? Center(
                                        child: Text(" 'Search by Name' ",style: TextStyle(color: kFontColour,fontSize: 18),),
                                      )
                                    : ScrollConfiguration(
                                        behavior: BounceScroll(),
                                        child: ListView.builder(
                                            itemCount: books.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    /*Text(
                                                      books[index].id,
                                                      style: TextStyle(
                                                        color: Color(0xffd5c0f4)
                                                      ),

                                                       ),*/
                                                    IntrinsicHeight(
                                                      child: Text(
                                                          books[index].name,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: kFontColour
                                                      ),),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                              ),
                            )
                          ],
                        )
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
