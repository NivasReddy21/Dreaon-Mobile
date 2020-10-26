import 'dart:ui';

import '../constants/routes.dart';

import '../global_widgets/circular_image.dart';

import '../models/post.dart';
import 'package:flutter/material.dart';

import 'post_actions.dart';
import 'post_content.dart';
import 'post_tags.dart';

class PostTileAlt extends StatefulWidget {
  final Post post;
  final double imageSize;
  final bool showShare;
  final bool showComments;
  final Color color;
  final double elevation;
  final bool canTapUserProfile;

  const PostTileAlt(
      {Key key,
      this.post,
      this.imageSize = 250.0,
      this.showShare = false,
      this.showComments = false,
      this.color,
      this.elevation = 4,
      this.canTapUserProfile = true})
      : super(key: key);

  @override
  _PostTileAltState createState() => _PostTileAltState();
}

class _PostTileAltState extends State<PostTileAlt> {
  void navigateToProfile(String userName) {
    Navigator.of(context).pushNamed(AppRoutes.profile, arguments: userName);
  }

  bool liked = false;
  @override
  Widget build(BuildContext context) {
    final br = 8.0;

    final userDetails = ListTile(
      onTap: widget.canTapUserProfile
          ? () => navigateToProfile(widget.post.user.username)
          : null,
      leading: CircularImage(
        image: widget.post.user.photo,
        size: 40.0,
      ),
      title: Text(
        widget.post.user.name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        "2 hours ago",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );

    final image = Visibility(
      visible: widget.post.photo != null,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        height: widget.imageSize,
        decoration: BoxDecoration(
          image: widget.post.photo == null
              ? null
              : DecorationImage(
                  image: NetworkImage(widget.post.photo),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );

    final tags = PostTags(post: widget.post);
    final content = PostContent(post: widget.post);
    final bottom = PostActions(
      post: widget.post,
      showShare: widget.showShare,
      showComments: widget.showComments,
    );

    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(br),
      ),
      elevation: widget.elevation,
      color: widget.color ?? Theme.of(context).scaffoldBackgroundColor,
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutes.postDetails,
        arguments: widget.post,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [userDetails, image, tags, content, bottom],
      ),
    );
  }
}
