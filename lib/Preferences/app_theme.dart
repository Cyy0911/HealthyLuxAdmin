import 'package:flutter/material.dart';

class AppTheme {
  static const Color whiteColor = Colors.white;
  static const Color transparentColor = Colors.transparent;
  static const Color blueColor = Colors.blue;
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color orangeColor = Colors.orange;
  static const Color purpleColor = Colors.purple;
  static const Color blackColor = Colors.black;

  static const Color darkblueColor = Color(0xff00467F);
  static const Color lightblueColor = Color(0xff006083);
  static const Color bluegreenColor = Color(0xff00828d);
  static const Color lightgreenColor = Color(0xff87c4bc);

  static TextStyle defaultTextStyle40White(bool isBold) {
    return TextStyle(
        fontSize: 40,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle20White(bool isBold) {
    return TextStyle(
        fontSize: 20,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle18White(bool isBold) {
    return TextStyle(
        fontSize: 18,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle16White(bool isBold) {
    return TextStyle(
        fontSize: 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }

  static TextStyle defaultTextStyle14White(bool isBold) {
    return TextStyle(
        fontSize: 14,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: whiteColor);
  }
}
