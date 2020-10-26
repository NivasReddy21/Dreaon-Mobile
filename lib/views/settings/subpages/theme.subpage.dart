import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../../utils/theme_utils.dart';
import '../../../global_widgets/switcher_tile.dart';
import 'package:flutter/material.dart';

class ThemeSubpage extends StatefulWidget {
  @override
  _ThemeSubpageState createState() => _ThemeSubpageState();
}

class _ThemeSubpageState extends State<ThemeSubpage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        isDarkMode = ThemeUtils.isDarkMode(context);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Column(
            children: [
              SwitcherTile(
                title: "Enable Dark Mode",
                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                  ThemeUtils.setThemeMode(context, isDarkMode);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
