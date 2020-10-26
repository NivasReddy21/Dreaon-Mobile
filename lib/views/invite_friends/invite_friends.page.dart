import '../../constants/data.dart';
import '../../constants/routes.dart';
import '../../global_widgets/header_text.dart';
import '../../views/invite_friends/widget/user_tile.dart';
import 'package:flutter/material.dart';
import '../../config/extensions.dart';

class InviteFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = AppData.users;
    users.shuffle();
    final header = HeaderText(text: "Invite Friends");

    final list = Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 40.0),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return UserTile(
            user: users[index],
          ).fadeInList(index, true);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.tabs,
                );
              },
              child: Text(
                "NEXT",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            list
          ],
        ),
      ),
    );
  }
}
