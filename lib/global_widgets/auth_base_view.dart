import 'package:flutter/material.dart';

class AuthBaseView extends StatelessWidget {
  final Widget body;

  const AuthBaseView({
    Key key,
    @required this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
  }
}
