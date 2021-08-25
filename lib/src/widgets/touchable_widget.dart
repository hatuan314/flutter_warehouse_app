import 'package:flutter/material.dart';

class TouchableWidget extends StatelessWidget {
  final BoxDecoration decoration;
  final Function  onPressed;
  final Function onLongPressed;
  final Widget child;
  final BorderRadiusGeometry borderRadiusEffect;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double width;
  final double height;

  TouchableWidget({
    @required this.onPressed,
    this.onLongPressed,
    @required this.child,
    this.decoration,
    this.borderRadiusEffect,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
      child: Stack(children: <Widget>[
        Container(
          child: Center(
            child: child,
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Color.fromRGBO(204, 223, 242, 0.2),
              splashColor: Color.fromRGBO(204, 223, 242, 0.4),
              customBorder: RoundedRectangleBorder(
                  borderRadius: borderRadiusEffect ?? decoration?.borderRadius ?? BorderRadius.all(Radius.circular(6))),
              onTap: onPressed,
              onLongPress: onLongPressed,
            ),
          ),
        ),
      ]),
    );
  }
}
