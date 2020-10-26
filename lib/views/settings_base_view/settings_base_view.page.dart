import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../models/settings_base_view.dart';
import 'package:flutter/material.dart';

class SettingsBaseViewPage extends StatelessWidget {
  final SettingsBaseView baseView;

  const SettingsBaseViewPage({
    Key key,
    @required this.baseView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(
            baseView.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          elevation: 1,
        ),
        body: baseView.body,
      ),
    );
  }
}
