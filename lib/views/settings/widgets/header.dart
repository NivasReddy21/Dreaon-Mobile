import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  const Header({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
