import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;

  const IconBtn({
    Key key,
    this.icon,
    this.color,
    this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _icon = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
    );

    final _desc = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 12.0,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[_icon, _desc],
      ),
    );
  }
}
