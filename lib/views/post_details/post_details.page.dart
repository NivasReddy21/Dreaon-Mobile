import 'dart:io';

import 'package:buddy/services/db.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../utils/theme_utils.dart';
import '../../utils/utils.dart';
import '../../global_widgets/custom_form_field_alt.dart';
import '../../global_widgets/header_text.dart';
import '../../models/comment.dart';
import '../../views/comments/widgets/comment_tile.dart';
import '../../config/extensions.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../global_widgets/post_content.dart';
import '../../global_widgets/post_tags.dart';

import '../../global_widgets/circular_image.dart';

import '../../models/post.dart';
import 'package:flutter/material.dart';

import 'widgets/post_details_actions.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  TextEditingController controller = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  addMessage({User user, String postId}) async {
    if (controller.text != "") {
      await FirebaseProviver()
          .addComment(user: user, content: controller.text, postId: postId);
      setState(() {
        controller.text = "";
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeIn,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasPhoto = widget.post.photo == null ? false : true;
    var user = Provider.of<User>(context);
    final postImage = Container(
      height: hasPhoto ? 300.0 : 30.0,
      width: double.infinity,
      decoration: !hasPhoto
          ? null
          : BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.post.photo,
                ),
                fit: BoxFit.cover,
              ),
            ),
    );

    final userDetails = ListTile(
      leading: Hero(
        tag: widget.post.user.photo,
        child: CircularImage(
          image: widget.post.user.photo,
          // size: 40.0,
        ),
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

    final tags = PostTags(post: widget.post);
    final content = PostContent(
      post: widget.post,
      maxLines: 10,
    );

    final bottom = PostDetailsActions(post: widget.post);

    final close = Positioned(
      right: -10.0,
      top: 30.0,
      child: Visibility(
        visible: !hasPhoto,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          shape: CircleBorder(),
          child:
              Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );

    final back = Positioned(
      left: -10.0,
      top: 30.0,
      child: Visibility(
        visible: hasPhoto,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          color: Colors.grey.withOpacity(0.8),
          shape: CircleBorder(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );

    final commentBox = Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 5,
            bottom: Platform.isIOS ? 15 : 5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: ThemeUtils.isDarkMode(context)
                    ? Colors.black54
                    : Colors.grey.withOpacity(0.4),
                blurRadius: 6.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: CustomFormFieldAlt(
            controller: controller,
            hintText: "Write a comment",
            bottomPadding: 0,
            prefixIcon: Icon(FlutterIcons.edit_3_fea),
            suffixIcon: IconButton(
              onPressed: () =>
                  addMessage(user: user, postId: widget.post.postId),
              icon: Icon(
                LineAwesomeIcons.paper_plane,
                color: Theme.of(context).primaryColor,
                size: 26,
              ),
            ),
          ),
        ));

    final pageElements = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        postImage,
        userDetails,
        tags,
        content,
        bottom,
      ],
    );

    final commentSection = Container(
      child: Container(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: HeaderText(
              text: "Comments",
              fontSize: 22,
            ),
          ),
        ]),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .doc(widget.post.postId)
                  .collection("comments")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<Comment> comments =
                    docs.map((doc) => Comment.fromMap(doc.data())).toList();
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[pageElements, commentSection],
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Column(
                              children: [
                                CommentTile(
                                  comment: comments[index],
                                ),
                                Visibility(
                                  visible: comments.length - 1 != index,
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ).fadeInList(index, true);
                          },
                          childCount: comments.length,
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate(
                        [
                          Utils.verticalSpacer(space: 80),
                        ],
                      ))
                    ],
                  ),
                );
              }),
          close,
          back,
          commentBox
        ],
      ),
    );
  }
}
