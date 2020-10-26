import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const IconTile({
    Key key,
    @required this.icon,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
