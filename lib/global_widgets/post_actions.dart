import 'package:buddy/services/db.dart';
import 'package:buddy/services/share.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';

import '../utils/utils.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../models/post.dart';
import 'package:flutter/material.dart';

import 'icon_button.dart';

class PostActions extends StatefulWidget {
  final Post post;
  final bool showShare;
  final bool showComments;

  const PostActions({
    Key key,
    this.post,
    this.showShare = true,
    this.showComments = true,
  }) : super(key: key);

  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                IconBtn(
                  leadingIcon: widget.post.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  value: widget.post.likesCount,
                  color: widget.post.isLiked
                      ? Theme.of(context).primaryColor
                      : null,
                  onTap: () async {
                    await FirebaseProviver().like(user.uid, widget.post.postId);
                  },
                ),
                Utils.horizontalSpacer(
                  space: 10,
                ),
                Visibility(
                  visible: widget.showComments,
                  child: IconBtn(
                    leadingIcon: FlutterIcons.comment_text_outline_mco,
                    value: widget.post.commentsCount,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.comments,
                          arguments: widget.post.postId);
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.showShare,
            child: IconBtn(
              leadingIcon: FlutterIcons.share_2_fea,
              onTap: () => ShareService().share(context, widget.post),
            ),
          ),
        ],
      ),
    );
  }
}
