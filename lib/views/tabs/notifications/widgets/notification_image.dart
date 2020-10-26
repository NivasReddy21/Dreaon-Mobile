import 'package:flutter/material.dart';

class NotificationImage extends StatelessWidget {
  final String image;
  final double size;

  const NotificationImage({
    Key key,
    @required this.image,
    this.size = 50.0
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
