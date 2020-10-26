import '../../../models/message.dart';
import '../../../config/extensions.dart';

import '../../../global_widgets/tab_base_view.dart';
import '../../../models/user.dart';
import '../../../views/tabs/messages/widgets/online_user_tile.dart';

import '../../../constants/data.dart';
import '../../../views/tabs/messages/widgets/message_tile.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users = AppData.users.getRange(5, 10).toList();
    List<Message> messages = AppData.messages;

    final onlineFriends = Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return OnlineUserTile(
            user: users[index],
          ).fadeInList(index, false);
        },
      ),
    );

    final list = Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: 40.0),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageTile(
              message: messages[index],
            ).fadeInList(index, true);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.0);
          },
        ),
      ),
    );

    return TabBaseView(
      title: "Messages",
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [onlineFriends, list],
        ),
      ),
    );
  }
}
