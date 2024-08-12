import 'package:flutter/material.dart';

class ScreenSize {
  static late double widthMed;
  static late double heightMed;

  static void initialize(BuildContext context) {
    widthMed = MediaQuery.of(context).size.width;
    heightMed = MediaQuery.of(context).size.height;
  }
}
