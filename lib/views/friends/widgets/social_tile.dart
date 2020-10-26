import 'package:flutter/material.dart';

class SocialTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color backgroundColor;

  const SocialTile({
    Key key,
    this.icon,
    this.name,
    this.backgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _icon = Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        icon,
        color: backgroundColor,
      ),
    );
    final _name = Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final _connect = Container(
      child: Text(
        "Connect",
        style: TextStyle(color: Colors.white54),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 5),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        onPressed: () {},
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon,
            _name,
            _connect,
          ],
        ),
      ),
    );
  }
}
