import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const primaryLight = Color(0xffAEA6A6);
const primaryLightText = Color(0xff000000);


LinearGradient gradBg = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.5,0.8],
  colors: [
    Color(0xffe58c8a),
    Color(0xffeec0c6),
    Color(0xfff5e3e6),
  ],
);

LinearGradient gradBgReverse = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomLeft,
  stops: [0.1, 0.5,0.8],
  colors: [
    Color(0xfff5e3e6),
    Color(0xffeec0c6),
    Color(0xff861657)
  ],
);

LinearGradient containerBg = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.1,0.5,0.8],
  colors: [
    Color(0xffa40606),
    Color(0xffa4508b),
    Color(0xfff7b42c),

  ]
);
