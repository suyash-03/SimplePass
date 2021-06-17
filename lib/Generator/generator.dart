import 'dart:math';

import 'package:flutter/material.dart';

class GeneratorClass {
  String generatePassword() {
    final lettersUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ;
    final lettersLowerCase = ' abcdefghijklmnopqrstuvwxyz' ;
    final numbers = '1234567890';
    final specialChars = '!@#%^&*()';
    final length = 20;

    String pass ='';
    pass += '$lettersLowerCase$lettersUpperCase';
    pass += '$numbers';
    pass += '$specialChars';
    
    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(pass.length);
      return pass[indexRandom];
    }).join('');
  }
}
