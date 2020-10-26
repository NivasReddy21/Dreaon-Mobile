import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final int index;

  const DotIndicator({Key key, this.isActive, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double size = 10.0;
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: size,
      width: isActive ? 30.0 : size,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        border: Border.all(width: 1, color: Colors.white),
      ),
    );
  }
}
