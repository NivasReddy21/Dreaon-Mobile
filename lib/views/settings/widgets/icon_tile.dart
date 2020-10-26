import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const IconTile({
    Key key,
    @required this.icon,
    @required this.title,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: listTile(
        leading: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
          size: 20,
        ),
        title: Container(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  listTile({
    Widget leading,
    Widget title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: leading,
          ),
          Expanded(child: title),
        ],
      ),
    );
  }
}
