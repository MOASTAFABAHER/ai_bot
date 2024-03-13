import 'package:flutter/material.dart';

class AppNavigator {
  static printt() {
    print(' I am Printing');
  }

  static appNavigator(context, screen, {isFinished = false}) {
    if (isFinished == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }
}
