import '../../../constants/data.dart';
import '../../../models/notification.dart';
import '../../../views/tabs/notifications/widgets/notification_tile.dart';
import '../../../config/extensions.dart';

import '../../../global_widgets/tab_base_view.dart';
import 'package:flutter/material.dart';

class NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<AppNotification> notifications = AppData.notifications;

    final list = Container(
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 40.0),
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return NotificationTile(
            notification: notifications[index],
          ).fadeInList(index, false);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
      ),
    );

    return TabBaseView(
      title: "Notifications",
      body: Container(
        child: list,
      ),
    );
  }
}
