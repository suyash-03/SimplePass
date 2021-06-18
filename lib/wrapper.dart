import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/Generator/generator.dart';
import 'package:password_generator/Screens/homepage.dart';
import 'package:password_generator/Screens/start_screen.dart';
import 'package:password_generator/shared/loading_pulse.dart';
import 'package:provider/provider.dart';
import 'Authentication/googleSignIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return Loading();
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return StartScreen();
            }
          },
        ),
      );
}
