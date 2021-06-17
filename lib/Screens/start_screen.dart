import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Authentication/googleSignIn.dart';
import 'package:password_generator/Constants/colors.dart';
import 'package:provider/provider.dart';
import '../Constants/rotateTextStyle.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: controller,
      children: <Widget>[pageOne(), pageTwo()],
    );
  }

  //Page One of PageView
  Widget pageOne() {
    return Container(
      decoration: BoxDecoration(gradient: gradBg),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: ClipPath(
                clipper: SideCutClipper(),
                child: Container(
                  color: Color(0xffe5a3a3),
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInUp(
                            child: Image.asset(
                              'assets/c1.png',
                              height: 800,
                              width: 800,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ZoomIn(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    height: 80,
                    width: 100,
                    child: DefaultTextStyle(
                      style: rotateTextStyle,
                      child:
                          AnimatedTextKit(repeatForever: true, animatedTexts: [
                        RotateAnimatedText('Strong'),
                        RotateAnimatedText('Secure'),
                        RotateAnimatedText('Solid'),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    child: Text(
                      'Passwords',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 25,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ZoomIn(
              child: Container(
                  child: IconButton(
                    iconSize: 50,
                    color: Colors.grey[700],
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                    icon: Icon(Icons.arrow_downward_rounded),
                  )),
            )
          ],
        ),
      ),
    );
  }

  //Page 2 of PageView
  Widget pageTwo() {
    return Container(
      decoration: BoxDecoration(gradient: gradBgReverse),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              ZoomIn(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        iconSize: 50,
                        color: Colors.grey[700],
                        onPressed: () {
                          controller.previousPage(
                              duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                        icon: Icon(Icons.arrow_upward),
                      )),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              FadeInUp(
                child: RichText(
                  text: TextSpan(
                    text:  "Your Generated ",
                    style: rotateTextStyle,
                    children: const<TextSpan>[
                      TextSpan(text: "Passwords\n",style: TextStyle(color: Colors.pink),),
                      TextSpan(text: "Sync Across your Devices"),
                    ]
                  )
                ),
              ),
              SizedBox(
                height: 80,
              ),
              FadeInUp(
                child: Text(
                  "SignIn to Continue",
                  style: rotateTextStyle2,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FadeInUp(
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent[200],
                          offset: const Offset(
                            5.0,
                            8.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffeec0c6)),
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LogIn with Google",
                          style: TextStyle(color: Color(0xff861657)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.pinkAccent,
                        )
                      ],
                    ),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                      provider.login(context);
                    },
                  ),
                ),
              ),
              FadeInUp(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: Image.asset(
                      'assets/b1.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
