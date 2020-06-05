import 'package:flutter/material.dart';

Map<String, RepresentColor> distributorColors = {
  '0': RepresentColor(Colors.blue, Colors.blue[800]),
  '1': RepresentColor(Colors.blueGrey, Colors.blueGrey[800]),
  '2': RepresentColor(Colors.lightBlue, Colors.lightBlue[800]),
  '3': RepresentColor(Colors.cyan, Colors.cyan[800]),
  '4': RepresentColor(Colors.green, Colors.green[800]),
  '5': RepresentColor(Colors.lightGreen, Colors.lightGreen[800]),
  '6': RepresentColor(Colors.teal, Colors.teal[800]),
  '7': RepresentColor(Colors.indigoAccent, Colors.indigo[800]),
  '9': RepresentColor(Colors.deepPurpleAccent, Colors.deepPurple[800]),
  '10': RepresentColor(Colors.purpleAccent, Colors.purple[800]),
  '11': RepresentColor(Colors.pinkAccent, Colors.pink),
  '12': RepresentColor(Colors.redAccent, Colors.red[800]),
  '13': RepresentColor(Colors.deepOrangeAccent, Colors.deepOrange[800]),
  '14': RepresentColor(Colors.orangeAccent, Colors.orange[800]),
  '15': RepresentColor(Colors.amberAccent, Colors.amber[800]),
  '16': RepresentColor(Colors.yellowAccent, Colors.yellow[800]),
  '17': RepresentColor(Colors.limeAccent, Colors.lime[800]),
  '18': RepresentColor(Colors.brown[400], Colors.brown[800]),
  '19': RepresentColor(Colors.grey[400], Colors.grey[800]),
  '20': RepresentColor(Colors.black38, Colors.black87)
};

class RepresentColor {
  Color backgroundColor;
  Color textColor;

  RepresentColor(this.backgroundColor, this.textColor);
}