import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback onTap;

  const CallButton({
    Key key,
    this.color = Colors.white,
    @required this.iconColor,
    @required this.icon,
    this.iconSize = 24,
    this.size = 16.0,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: color,
      shape: CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(size),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
