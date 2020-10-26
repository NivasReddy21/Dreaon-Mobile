import '../utils/theme_utils.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeUtils.isDarkMode(context) ? null : Theme.of(context).primaryColor
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
