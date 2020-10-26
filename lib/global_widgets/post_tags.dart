import '../models/post.dart';
import 'package:flutter/material.dart';

class PostTags extends StatelessWidget {
  final Post post;

  const PostTags({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Wrap(
        spacing: 10.0,
        children: post.tags.map(
          (e) {
            return Text(
              "#$e",
              style: TextStyle(color: Theme.of(context).primaryColor),
            );
          },
        ).toList(),
      ),
    );
  }
}
