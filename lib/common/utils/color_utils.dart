import 'package:flutter/material.dart';

class ColorUtils {
  static int parseInt(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return value;
  }

  static Color convertColor(int value) {
    return Color(value);
  }
}
