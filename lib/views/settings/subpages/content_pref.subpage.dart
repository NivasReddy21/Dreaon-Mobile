import '../../../views/settings/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class ContentPrefSubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          SettingsSection(
            title: "Video Languages",
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Add Language",
                  style: TextStyle(fontSize: 14.0),
                ),
                subtitle: Text(
                  "Your language preference will help us customize your viewing experience",
                  style: TextStyle(fontSize: 13.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
