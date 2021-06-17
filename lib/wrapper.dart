import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/Generator/generator.dart';
import 'package:password_generator/Screens/homepage.dart';
import 'package:password_generator/Screens/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Authentication/googleSignIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => GoogleSignInProvider(),
            ),
            Provider(create: (context)=> GeneratorClass())
          ],
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return HomePage();
              } else {
                return StartScreen();
              }
            },
          ),
        ),
      );

  Widget buildLoading() {
    return Container(
      color: Color(0xffeec0c6),
      child: SpinKitPulse(
        color: Colors.pinkAccent,
        size: 100,
      ),
    );
  }
}
