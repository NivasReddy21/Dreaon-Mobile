import 'package:flutter/material.dart';

class CustomTabBar extends Container implements PreferredSizeWidget {
  final Color color;
  final TabBar tabBar;
  
  CustomTabBar(this.color, this.tabBar);

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: tabBar,
  );
}