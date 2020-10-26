import '../../../../utils/utils.dart';
import '../../../../global_widgets/circular_image.dart';
import '../../../../global_widgets/outline_gradient_button.dart';
import '../../../../views/tabs/notifications/widgets/notification_image.dart';

import '../../../../models/notification.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;

  const NotificationTile({
    Key key,
    this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userImage = CircularImage(
      image: notification.user.photo,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getTitle() ?? "NULL",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.subtitle1.color,
          ),
        ),
        _getData(),
        Text(
          "2 hours ago",
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MaterialButton(
        onPressed: () {},
        elevation: 0,
        child: Row(
          children: <Widget>[
            userImage,
            Utils.horizontalSpacer(space: 17.0),
            Expanded(
              child: content,
            )
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    String title = notification.user.name;
    if (notification.isFollow) {
      title += " followed you";
    }

    if (notification.isLike) {
      title += " liked your photo";
    }

    if (notification.isReaction) {
      title += " reacted to your story";
    }

    if (notification.isComment) {
      title += " commented on your photo";
    }

    if (notification.isAddPhotos) {
      title += " added ${notification.photos.length} new photos";
    }

    return title;
  }

  Widget _getData() {
    if (notification.isFollow) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: OutlineGradientButton(
          text: "Follow",
          onPressed: () {},
        ),
      );
    } else if (notification.isLike) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: NotificationImage(
          image: notification.photos[0],
        ),
      );
    } else if (notification.isReaction) {
      return Container(
        child: Text(notification.comment),
      );
    } else if (notification.isComment) {
      return Container(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            notification.comment,
            style: TextStyle(
              fontSize: 13.0,
            ),
            maxLines: 2,
          ),
          trailing: NotificationImage(
            image: notification.photos[0],
          ),
        ),
      );
    } else if (notification.isAddPhotos) {
      return Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 60.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: notification.photos
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: NotificationImage(image: e),
                ),
              )
              .toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}
