import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class CountTile extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback onTap;

  const CountTile({
    Key key,
    @required this.title,
    @required this.value,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              Utils.formatNumber(value),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
