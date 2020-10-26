import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class EmojiSelector extends StatelessWidget {
  final ValueChanged<String> onTap;

  const EmojiSelector({
    Key key,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _buildSelector(context, FlutterIcons.thumbs_up_fea, "Yes"),
          SizedBox(width: 15.0),
          _buildSelector(context, FlutterIcons.thumbs_down_fea, "No"),
        ],
      ),
    );
  }

  Widget _buildSelector(
    BuildContext context,
    IconData icon,
    String value,
  ) {
    final color = Theme.of(context).colorScheme.onPrimary;
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: color),
        onPressed: () => onTap(value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 10.0),
            Text(
              value,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
