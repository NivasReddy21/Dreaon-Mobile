import '../../../../constants/routes.dart';
import '../../../../global_widgets/circular_image.dart';
import '../../../../models/message.dart';
import 'package:flutter/material.dart';
import '../../../../config/extensions.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({
    Key key,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => Navigator.of(context).pushNamed(
        AppRoutes.messageDetails,
        arguments: message.user,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 14.0),
        leading: Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Hero(
            tag: "${message.user.name}-image",
            child: CircularImage(image: message.user.photo),
          ),
        ).badge(message.unread),
        title: Text(
          message.user.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        subtitle: Text(message.content),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(message.time, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
