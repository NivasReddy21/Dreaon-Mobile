import '../../../global_widgets/switcher_tile.dart';
import '../../../views/settings/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class PrivacySafetySubpage extends StatefulWidget {
  @override
  _PrivacySafetySubpageState createState() => _PrivacySafetySubpageState();
}

class _PrivacySafetySubpageState extends State<PrivacySafetySubpage> {
  bool privAccount = false;
  bool suggAccount = true;
  bool ad = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          SettingsSection(
            title: "Discoverability",
            children: <Widget>[
              SwitcherTile(
                title: "Private account",
                subtitle: "With a private account, only users you approve can follow you and view your videos and likes. Your existing followers won't be affected.",
                value: privAccount,
                onChanged: (bool value) {
                  setState(() {
                    privAccount = !privAccount;
                  });
                },
              ),
              SwitcherTile(
                title: "Suggest your account to others",
                subtitle: "Choose whether your profile can be suggested to users interested in accounts like yours.",
                value: suggAccount,
                onChanged: (bool value) {
                  setState(() {
                    suggAccount = !suggAccount;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            showUnderline: false,
            title: "Personalization & Data",
            children: <Widget>[
              SwitcherTile(
                title: "Ad authorization",
                subtitle: "Allow advertisers to feature your content in ads",
                value: ad,
                onChanged: (bool value) {
                  setState(() {
                    ad = !ad;
                  });
                },
              ),
            ],
          ),
        ]
      ),
    );
  }
}