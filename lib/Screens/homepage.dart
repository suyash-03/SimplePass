import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Authentication/googleSignIn.dart';
import 'package:password_generator/Constants/colors.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/Generator/generator.dart';
import 'package:password_generator/Screens/generatePage.dart';
import 'package:password_generator/Screens/savedPasswords.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController controller = PageController(initialPage: 0);

  void onButtonPageChange(){
    controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
  void onButtonPageChangeBack(){
    controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }


  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[GeneratePage(onButtonPageChange), SavedPasswords(onButtonPageChangeBack)],
    );
  }
}
