import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/models/distributor/represent_color_model.dart';
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

  static Map<String, RepresentColorModel> distributorColors = {
    '0': RepresentColorModel(Colors.blue, Colors.blue[800]),
    '1': RepresentColorModel(Colors.blueGrey, Colors.blueGrey[800]),
    '2': RepresentColorModel(Colors.lightBlue, Colors.lightBlue[800]),
    '3': RepresentColorModel(Colors.cyan, Colors.cyan[800]),
    '4': RepresentColorModel(Colors.green, Colors.green[800]),
    '5': RepresentColorModel(Colors.lightGreen, Colors.lightGreen[800]),
    '6': RepresentColorModel(Colors.teal, Colors.teal[800]),
    '7': RepresentColorModel(Colors.indigoAccent, Colors.indigo[800]),
    '9': RepresentColorModel(Colors.deepPurpleAccent, Colors.deepPurple[800]),
    '10': RepresentColorModel(Colors.purpleAccent, Colors.purple[800]),
    '11': RepresentColorModel(Colors.pinkAccent, Colors.pink),
    '12': RepresentColorModel(Colors.redAccent, Colors.red[800]),
    '13': RepresentColorModel(Colors.deepOrangeAccent, Colors.deepOrange[800]),
    '14': RepresentColorModel(Colors.orangeAccent, Colors.orange[800]),
    '15': RepresentColorModel(Colors.amberAccent, Colors.amber[800]),
    '16': RepresentColorModel(Colors.yellowAccent, Colors.yellow[800]),
    '17': RepresentColorModel(Colors.limeAccent, Colors.lime[800]),
    '18': RepresentColorModel(Colors.brown[400], Colors.brown[800]),
    '19': RepresentColorModel(Colors.grey[400], Colors.grey[800]),
    '20': RepresentColorModel(Colors.black38, Colors.black87)
  };

  static void dismissKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
