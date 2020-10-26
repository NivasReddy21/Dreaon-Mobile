import '../../../constants/routes.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../global_widgets/post_tile_alt.dart';
import '../../../config/extensions.dart';

import '../../../constants/data.dart';

import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreTab extends StatefulWidget {
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  List<String> tabs = [
    "Popular",
    "Latest",
    "Most Liked",
    "Most Viewed",
  ];
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    posts = [];
    posts.addAll(List.from(AppData().posts));
    posts.addAll(List.from(AppData().postsNoPhotos));
    posts.shuffle();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final list = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return PostTileAlt(
          post: posts[index],
          imageSize: 150.0,
          showShare: false,
          showComments: false,
          elevation: 0,
          color: Theme.of(context).colorScheme.primary,
        ).fadeInList(index, false);
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.fit(2);
      },
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );

    final tabBar = TabBar(
      controller: tabController,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey.withOpacity(0.3),
      isScrollable: true,
      tabs: tabs
          .map(
            (tabName) => Tab(
              child: Text(
                tabName,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
    );

    final tabBarView = Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        margin: EdgeInsets.only(top: 20.0),
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            list,
            list,
            list,
            list,
          ],
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.liveTv);
        },
        child: Icon(
          FlutterIcons.television_play_mco,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[tabBar, tabBarView],
        ),
      ),
    );
  }
}
