import '../../constants/data.dart';
import '../../constants/routes.dart';
import '../../utils/utils.dart';
import '../../config/extensions.dart';
import 'widgets/follower_tile.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../models/user.dart';
import 'package:flutter/material.dart';

class FollowersPage extends StatefulWidget {
  final User user;

  const FollowersPage({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List tabs;
  List<User> followers;
  List<User> following;

  @override
  void initState() {
    tabs = [
      "FOLLOWING ${Utils.formatNumber(widget.user.following)}",
      "FOLLOWERS ${Utils.formatNumber(widget.user.followers)}",
    ];
    super.initState();
    tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    followers = AppData.users.where((e) => e.id != '').toList();
    following = followers;
    followers.shuffle();
    following.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      labelColor: Theme.of(context).primaryColor,
      indicatorColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey.withOpacity(0.6),
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
      tabs: tabs.map((tab) {
        var index = tabs.indexOf(tab);
        return Tab(
          text: tabs[index],
        );
      }).toList(),
      controller: tabController,
    );

    final tabBarView = TabBarView(
      controller: tabController,
      children: [
        ListView.separated(
          padding: EdgeInsets.only(bottom: 40.0),
          itemCount: following.length,
          itemBuilder: (BuildContext context, int index) {
            return FollowerTile(
              user: following[index],
            ).fadeInList(index, false);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.0);
          },
        ),
        ListView.separated(
          padding: EdgeInsets.only(bottom: 40.0),
          itemCount: followers.length,
          itemBuilder: (BuildContext context, int index) {
            return FollowerTile(
              user: followers[index],
            ).fadeInList(index, false);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.0);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "@${widget.user.username}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FlutterIcons.user_plus_fea),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.friends,
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            tabBar,
            Expanded(
              child: tabBarView,
            )
          ],
        ),
      ),
    );
  }
}
