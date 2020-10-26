import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;

  const SocialButton({
    Key key,
    @required this.icon,
    @required this.backgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
      onPressed: () {},
      child: Icon(
        icon,
        color: Colors.white,
      ),
      color: backgroundColor,
    );
  }
}
