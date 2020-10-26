import '../../../global_widgets/switcher_tile.dart';
import '../../../views/settings/widgets/settings_section.dart';
import 'package:flutter/material.dart';

class PushNotificationsSubpage extends StatefulWidget {
  @override
  _PushNotificationsSubpageState createState() =>
      _PushNotificationsSubpageState();
}

class _PushNotificationsSubpageState extends State<PushNotificationsSubpage> {
  bool likes = true;
  bool comments = true;
  bool followers = false;
  bool mentions = true;
  bool messages = false;
  bool video1 = true;
  bool video2 = true;
  bool live = true;
  bool broadcast = false;
  bool customize = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          SettingsSection(
            title: "Interactions",
            children: <Widget>[
              SwitcherTile(
                title: "Likes",
                value: likes,
                onChanged: (bool value) {
                  setState(() {
                    likes = !likes;
                  });
                },
              ),
              SwitcherTile(
                title: "Comments",
                value: comments,
                onChanged: (bool value) {
                  setState(() {
                    comments = !comments;
                  });
                },
              ),
              SwitcherTile(
                title: "New Followers",
                value: followers,
                onChanged: (bool value) {
                  setState(() {
                    followers = !followers;
                  });
                },
              ),
              SwitcherTile(
                title: "Mentions",
                value: mentions,
                onChanged: (bool value) {
                  setState(() {
                    mentions = !mentions;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: "Messages",
            children: <Widget>[
              SwitcherTile(
                title: "Direct Messages",
                value: messages,
                onChanged: (bool value) {
                  setState(() {
                    messages = !messages;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: "Video Updates",
            children: <Widget>[
              SwitcherTile(
                title: "Videos from accounts you follow",
                value: video1,
                onChanged: (bool value) {
                  setState(() {
                    video1 = !video1;
                  });
                },
              ),
              SwitcherTile(
                title: "Videos suggestions",
                value: video2,
                onChanged: (bool value) {
                  setState(() {
                    video2 = !video2;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: "Live",
            children: <Widget>[
              SwitcherTile(
                title: "Live streams from accounts you follow",
                value: live,
                onChanged: (bool value) {
                  setState(() {
                    live = !live;
                  });
                },
              ),
              SwitcherTile(
                title: "Recommended broadcast",
                value: broadcast,
                onChanged: (bool value) {
                  setState(() {
                    broadcast = !broadcast;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: "Other",
            showUnderline: false,
            children: <Widget>[
              SwitcherTile(
                title: "Customize update and more",
                value: customize,
                onChanged: (bool value) {
                  setState(() {
                    customize = !customize;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
