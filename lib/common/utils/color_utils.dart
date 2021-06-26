import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/data/colors.dart';

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

  static Color randColor() {
    var rng = new Random();
    int index = rng.nextInt(colors.length);
    return colors[index];
  }
}
