import '../../constants/data.dart';
import '../../config/extensions.dart';
import '../../constants/routes.dart';
import '../../global_widgets/custom_form_field_alt.dart';
import '../../global_widgets/header_text.dart';
import '../../models/user.dart';
import '../../views/friends/widgets/social_tile.dart';
import '../../views/friends/widgets/user_friend_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<User> users;

  @override
  void initState() {
    super.initState();
    users = AppData.users;
  }

  @override
  Widget build(BuildContext context) {
    final header = HeaderText(text: "Friends");

    final searchBar = Container(
      margin: EdgeInsets.only(top: 10.0),
      child: CustomFormFieldAlt(
        hintText: "Search",
        readOnly: true,
        icon: LineAwesomeIcons.search,
        onTap: () async {
          await Navigator.pushNamed(
            context,
            AppRoutes.search,
          );
        },
        bottomPadding: 5,
      ),
    );

    final connect = Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(
        "Connect to find more friends",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final socialMedia = Container(
      height: 145.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SocialTile(
            name: "Twitter",
            icon: FlutterIcons.twitter_ant,
            backgroundColor: Color(0xFF1DA1F2),
          ).fadeInList(0, false),
          SocialTile(
            name: "Google",
            icon: FlutterIcons.google_ant,
            backgroundColor: Color(0xFFDB4437),
          ).fadeInList(1, false),
          SocialTile(
            name: "Facebook",
            icon: FlutterIcons.facebook_ent,
            backgroundColor: Color(0xFF4267B2),
          ).fadeInList(2, false),
        ],
      ),
    );

    final suggestions = Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        "Suggestions",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final customScroll = Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [connect, socialMedia, suggestions],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (
                BuildContext context,
                int index,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: UserFriendTile(
                    user: users[index],
                  ).fadeInList(index, true),
                );
              },
              childCount: users.length,
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            searchBar,
            customScroll,
          ],
        ),
      ),
    );
  }
}
