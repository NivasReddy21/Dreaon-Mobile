import '../../../views/settings/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class LanguageSubpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: <Widget>[
          SettingsSection(
            title: "App Language",
            children: <Widget>[
              SizedBox(height: 10.0),
              Text("English")
            ],
          )
        ],
      ),
    );
  }
}
