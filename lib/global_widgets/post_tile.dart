import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';

import '../constants/routes.dart';

import '../global_widgets/circular_image.dart';

import '../models/post.dart';
import 'package:flutter/material.dart';

import 'post_actions.dart';
import 'post_content.dart';
import 'post_tags.dart';

class PostTile extends StatefulWidget {
  final Post post;

  const PostTile({Key key, this.post}) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  void navigateToProfile(String userName) {
    Navigator.of(context).pushNamed(AppRoutes.profile, arguments: userName);
  }

  @override
  Widget build(BuildContext context) {
    final br = 8.0;

    final userDetails = Positioned(
      bottom: 20.0,
      left: 20.0,
      child: GestureDetector(
        onTap: () => navigateToProfile(widget.post.user.id),
        child: Container(
          width: 250.0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircularImage(
                image: widget.post.user.photo,
                size: 40.0,
              ),
              title: Text(
                widget.post.user.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                "2 hours ago",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final image = Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(br),
              topLeft: Radius.circular(br),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.post.photo),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        userDetails,
      ],
    );

    final tags = PostTags(post: widget.post);
    final content = PostContent(post: widget.post);
    final bottom = PostActions(post: widget.post);

    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(br),
      ),
      elevation: 4,
      color: Theme.of(context).scaffoldBackgroundColor,
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutes.postDetails,
        arguments: widget.post,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [image, tags, content, bottom],
      ),
    );
  }
}
