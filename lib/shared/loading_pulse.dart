import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffeec0c6),
      child: SpinKitPulse(
        color: Colors.pinkAccent,
        size: 100,
      ),
    );
  }
}
