import 'package:buddy/services/db.dart';
import 'package:buddy/views/tabs/profile/tabs/post_tabs_builder.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../../constants/images.dart';
import '../../../utils/utils.dart';
import '../../../config/extensions.dart';

import '../../../models/settings_base_view.dart';
import '../../../views/settings/subpages/account.subpage.dart';

import '../../../constants/routes.dart';

import '../../../global_widgets/circular_image.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/outline_gradient_button.dart';
import '../../../views/tabs/profile/tabs/images.tab.dart';
import '../../../views/tabs/profile/widgets/count_tile.dart';
import '../../../views/tabs/profile/widgets/custom_tabbar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../.././../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileTab extends StatefulWidget {
  final User userDetails;
  final bool isMyProfile;
  final bool isFollowing;

  const ProfileTab(
      {Key key, this.userDetails, this.isMyProfile, this.isFollowing})
      : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  List<User> users = [];

  User user;
  TabController tabController;
  List tabs = [
    FlutterIcons.post_outline_mco,
    LineAwesomeIcons.photo,
  ];
  bool isMyProfile = false;

  final currentUserId = auth.FirebaseAuth.instance.currentUser.uid;
  // void checkFollowing() async {
  //   bool isFollow = await FirebaseProviver()
  //       .checkIsFollowing(currentUserId, widget.userDetails.id);
  //   setState(() {
  //     widget.userDetails.isFollowing = isFollow;
  //   });

  //   print(widget.userDetails.isFollowing);
  // }

  @override
  void initState() {
    super.initState();
    user = widget.userDetails;
    tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    isMyProfile = widget.isMyProfile;
    if (isMyProfile == false) {
      widget.userDetails.isFollowing = widget.isFollowing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream followers = FirebaseProviver()
        .fetchStats(label: "followers", uid: user.id)
        .asStream();
    final Stream following = FirebaseProviver()
        .fetchStats(label: "following", uid: user.id)
        .asStream();

    final userImage = CircularImage(
      image: user.photo,
      size: 100,
    ).fadeInList(0, false);

    final username = Container(
      child: Text(
        "@${user.username}",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).fadeInList(1, false);

    final vd = Container(
      height: 30.0,
      child: VerticalDivider(),
    );

    final userCounts = Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder(
              stream: following,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot != null) {
                  return CountTile(
                    title: "Following",
                    value: snapshot.data.length,
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.followers,
                      arguments: user,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
          vd,
          StreamBuilder(
              stream: followers,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot != null) {
                  return CountTile(
                    title: "Followers",
                    value: snapshot.data.length,
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.followers,
                      arguments: user,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
          vd,
          CountTile(
            title: "Likes",
            value: user.likes,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppImages.likes,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(
                                "Total likes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "'${user.username}' total received ${Utils.formatNumber(user.likes)} Likes",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text("OK"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    ).fadeInList(2, false);

    final editProfileBtn = OutlineGradientButton(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AppRoutes.settingsBase,
          arguments: SettingsBaseView(
            title: "Update profile",
            body: AccountSubpage(
              user: user,
            ),
          ),
        );
      },
      text: "Edit Profile",
    );

    final messageBtn = OutlineGradientButton(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AppRoutes.messageDetails,
          arguments: user,
        );
      },
      text: "Message",
    );

    final followBtn = SizedBox(
      width: 120.0,
      child: CustomButton(
        wrap: true,
        onPressed: () async {
          if (!widget.userDetails.isFollowing) {
            await FirebaseProviver()
                .follow(currentUserId, widget.userDetails.id);
            setState(() {
              widget.userDetails.isFollowing = true;
            });
          } else {
            await FirebaseProviver()
                .unfollow(currentUserId, widget.userDetails.id);
            setState(() {
              widget.userDetails.isFollowing = false;
            });
          }
        },
        text: "Follow",
      ),
    );

    final editProfile = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: isMyProfile
          ? editProfileBtn
          : widget.userDetails.isFollowing
              ? messageBtn
              : followBtn,
    ).fadeInList(3, false);

    final userDetails = Container(
      margin: EdgeInsets.only(top: 70.0, bottom: 50.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[userImage, username, userCounts, editProfile],
      ),
    );

    final tabBar = CustomTabBar(
      Theme.of(context).scaffoldBackgroundColor,
      TabBar(
        labelColor: Theme.of(context).primaryColor,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey.withOpacity(0.6),
        tabs: tabs.map((tab) {
          var index = tabs.indexOf(tab);
          return Tab(
            icon: Icon(tabs[index]),
          );
        }).toList(),
        controller: tabController,
      ),
    );

    final tabBarView = TabBarView(
      controller: tabController,
      children: [
        PostTabBuilder(
          user: user,
        ),
        ImagesTab(),
      ],
    );

    final appBar = SliverAppBar(
      elevation: 1,
      leading: IconButton(
        icon: Icon(isMyProfile ? FlutterIcons.user_plus_fea : Icons.arrow_back),
        onPressed: () {
          isMyProfile
              ? Navigator.pushNamed(
                  context,
                  AppRoutes.friends,
                )
              : Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        user.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(FlutterIcons.settings_fea),
          onPressed: () => Navigator.of(context).pushNamed(
            AppRoutes.settings,
          ),
        )
      ],
      flexibleSpace: ListView(
        children: [
          userDetails,
        ],
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.5,
      pinned: true,
      bottom: tabBar,
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            appBar,
          ];
        },
        body: tabBarView,
      ),
    );
  }
}
