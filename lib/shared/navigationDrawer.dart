import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Constants/colors.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/Screens/homepage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          child: Container(
            decoration: BoxDecoration(gradient: gradBg), child: Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
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
                              'assets/c2.png',
                              height: 500,
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.home,
                  color: Colors.pink[800],
                ),
                title: Text(
                  'Home',
                  style: rotateTextStyle2,
                ),
                onTap: () => selectedItem(context, 0),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.addressCard,
                  color: Colors.pink[800],
                ),
                title: Text(
                  'About',
                  style: rotateTextStyle2,
                ),
                onTap: () => selectedItem(context, 1),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height/1.6,
                    // ),
                    Center(
                      child: Text(
                        "Made with ❤ on Flutter",
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Montserrat'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Colors.pink,
                            ),
                            onPressed: () async {}),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.github,
                              color: Colors.black,
                            ),
                            onPressed: () async {})
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
        break;
    }
  }
}
