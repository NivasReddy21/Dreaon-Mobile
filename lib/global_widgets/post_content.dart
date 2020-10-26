import '../models/post.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final Post post;
  final int maxLines;

  const PostContent({
    Key key,
    this.post,
    this.maxLines = 4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Text(
        post.content,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
