import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Authentication/googleSignIn.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/Generator/generator.dart';
import 'package:password_generator/shared/navigationDrawer.dart';
import 'package:provider/provider.dart';

class GeneratePage extends StatefulWidget {
  final void Function() pageButtonPress;

  GeneratePage(this.pageButtonPress);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final textController = TextEditingController();
  String finalGeneratedPassword = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final password = Provider.of<GeneratorClass>(context);
    finalGeneratedPassword = password.generatePassword();
    textController.text = finalGeneratedPassword;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final password = Provider.of<GeneratorClass>(context);


    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
      backgroundColor: Color(0xffe79aad),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.gripLines),
                    onPressed: () async {
                      _scaffoldKey.currentState.openDrawer();
                    })),
          ),
          FadeInDown(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Color(0xfffbe1e4),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 60, 20, 10),
                      child: FadeInDown(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser.photoURL),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Hi ",
                                    style: rotateTextStyle2,
                                    children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${FirebaseAuth.instance.currentUser.displayName}",
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ])),
                            SizedBox(
                              width: 80,
                            ),
                            Expanded(
                                child: Container(
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  provider.logout(context);
                                },
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    FadeInDown(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Welcome to",
                              style: rotateTextStyle2,
                            )),
                      ),
                    ),
                    FadeInDown(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 20, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Simple Pass",
                              style: rotateTextStyleHeading,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: FadeInDown(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 80, 30, 20),
                  child: Container(
                    child: TextField(
                      controller: textController,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: FaIcon(FontAwesomeIcons.copy),
                          onPressed: () {
                            //Copying to ClipBoard
                            final data =
                                ClipboardData(text: finalGeneratedPassword);
                            Clipboard.setData(data);

                            //Creating a SnackBar
                            final snackBar = SnackBar(
                              content: Text(
                                "Password Copied to Clipboard",
                                style: rotateTextStyle,
                              ),
                              backgroundColor: Color(0xfffbe1e4),
                            );
                            Scaffold.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(color: Colors.pink)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FadeInDown(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.deepPurple),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    finalGeneratedPassword = password.generatePassword();
                    textController.text = finalGeneratedPassword;
                  });
                  print(finalGeneratedPassword);
                },
                child: Text(
                  "Generate Another",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FadeInDown(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.deepPurple),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Save Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FadeInDown(
            child: FlatButton.icon(
              icon: FaIcon(FontAwesomeIcons.arrowRight),
              label: Text("View Saved Passwords"),
              onPressed: () {
                widget.pageButtonPress();
              },
            ),
          )
        ],
      ),
    );
  }
}
