import '../../../views/settings/widgets/header.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool showUnderline;

  const SettingsSection({
    Key key,
    this.title,
    this.children,
    this.showUnderline = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hr = Visibility(
      visible: showUnderline,
      child: Divider(
        thickness: 0.5,
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            text: title,
          ),
          Column(
            children: children,
          ),
          hr
        ],
      ),
    );
  }
}
