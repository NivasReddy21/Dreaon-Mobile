import '../../../views/settings/widgets/report_tile.dart';
import '../../../views/settings/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class ReportProblemSubpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          SettingsSection(
            title: "Frequently Asked Questions",
            children: <Widget>[
              ReportTile(title: "Can't login"),
              ReportTile(title: "Deleting a post"),
              ReportTile(title: "Email is already registered"),
              ReportTile(title: "Cannot message a follower"),
              ReportTile(title: "How to get more followers"),
            ],
          ),
          SettingsSection(
            title: "Select a Topic",
            children: <Widget>[
               ReportTile(title: "Suggestions"),
               ReportTile(title: "Account and profile"),
               ReportTile(title: "Follow, likes and comments"),
               ReportTile(title: "Sharing"),
               ReportTile(title: "Posts"),
               ReportTile(title: "Photos and Videos"),
            ],
          ),
        ],
      ),
    );
  }
}
