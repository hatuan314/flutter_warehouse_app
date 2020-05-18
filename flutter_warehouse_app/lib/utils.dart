import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatMoney(double money) {
    if (money != null) {
      final formatCurrency = new NumberFormat("#,###", "vi").format(money);
      return formatCurrency.toString();
    } else {
      return "0.0";
    }
  }

  static List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Blueberry",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Hazelnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];

  static Map<String, Color> distributorColors = {
    '0': Colors.blue,
    '1': Colors.blueAccent,
    '2': Colors.blueGrey,
    '3': Colors.lightBlue,
    '4': Colors.lightBlueAccent,
    '5': Colors.cyan,
    '6': Colors.cyanAccent,
    '7': Colors.green,
    '8': Colors.greenAccent,
    '9': Colors.lightGreen,
    '10': Colors.lightGreen,
    '11': Colors.lightGreenAccent,
    '12': Colors.teal,
    '13': Colors.tealAccent,
    '14': Colors.indigo,
    '15': Colors.indigoAccent,
    '16': Colors.purple,
    '17': Colors.deepPurple,
    '18': Colors.deepPurpleAccent,
    '19': Colors.purple,
    '20': Colors.purpleAccent,
    '21': Colors.pinkAccent,
    '22': Colors.pink,
    '23': Colors.redAccent,
    '24': Colors.red,
    '25': Colors.deepOrange,
    '26': Colors.deepOrangeAccent,
    '27': Colors.orange,
    '28': Colors.orangeAccent,
    '29': Colors.amber,
    '30': Colors.amberAccent,
    '31': Colors.yellow,
    '32': Colors.yellowAccent,
    '33': Colors.lime,
    '34': Colors.limeAccent,
    '35': Colors.brown,
    '36': Colors.grey,
    '37': Colors.black
  };
}
