import 'package:buddy/services/dynamic_links.dart';
import 'package:buddy/views/tabs/profile/profile_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../views/tabs/explore/expore.dart';
import '../../views/tabs/home/home.dart';
import '../../views/tabs/notifications/notifications.dart';
import '../../utils/theme_utils.dart';
import '../../views/tabs/messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    ExploreTab(),
    MessagesTab(),
    NotificationsTab(),
    ProfileBuilder(
      userId: FirebaseAuth.instance.currentUser.uid,
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    DynamicLinkService().handleDynamicLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.6),
      elevation: 4.0,
      showUnselectedLabels: true,
      items: [
        bottomNavItem(icon: LineAwesomeIcons.home, title: 'Home'),
        bottomNavItem(icon: Icons.search, title: 'Explore'),
        bottomNavItem(
          icon: FlutterIcons.comment_discussion_oct,
          title: 'Inbox',
        ),
        bottomNavItem(
          icon: FlutterIcons.notification_ent,
          title: 'Notifications',
        ),
        bottomNavItem(
          icon: FlutterIcons.user_fea,
          title: 'Me',
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ThemeUtils.isDarkMode(context)
                  ? Colors.black54
                  : Colors.grey.withOpacity(0.4),
              blurRadius: 5,
            )
          ],
        ),
        child: bottomNavBar,
      ),
    );
  }

  BottomNavigationBarItem bottomNavItem({
    @required IconData icon,
    @required String title,
    IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
        icon: Icon(icon),
        activeIcon: activeIcon != null ? Icon(activeIcon) : null,
        label: title);
  }
}
