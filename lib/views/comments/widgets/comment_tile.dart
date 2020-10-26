import '../../../utils/utils.dart';
import '../../../global_widgets/circular_image.dart';

import '../../../models/comment.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({
    Key key,
    this.comment,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(
        image: comment.user.photo,
        size: 40,
      ),
      title: Text(comment.user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${comment.date}",
            style: TextStyle(
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
          Utils.verticalSpacer(space: 5.0),
          Text(
            comment.content,
            style: TextStyle(),
          ),
          Utils.verticalSpacer(space: 5.0),
          Text(
            "Reply",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
