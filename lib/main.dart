import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/wrapper.dart';
import 'package:provider/provider.dart';
import 'Authentication/googleSignIn.dart';
import 'Generator/generator.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        Provider(create: (context)=> GeneratorClass())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}


