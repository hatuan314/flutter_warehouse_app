import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


enum AnimationType { list, grid }

class AnimationWidget extends StatelessWidget {
  final int index;
  final Widget child;
  final AnimationType animationType;

  const AnimationWidget(
      {Key key,
      @required this.index,
      @required this.child,
      this.animationType = AnimationType.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animationType == AnimationType.grid) {
      return AnimationConfiguration.staggeredGrid(
        position: index,
        duration: const Duration(milliseconds: 500),
        columnCount: 2,
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: child,
          ),
        ),
      );
    }
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
