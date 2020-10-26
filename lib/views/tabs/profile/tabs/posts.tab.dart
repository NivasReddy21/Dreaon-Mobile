import '../../../../global_widgets/post_tile_alt.dart';
import '../../../../config/extensions.dart';
import '../../../../models/post.dart';
import '../../../../models/user.dart';
import 'package:flutter/material.dart';

class PostsTab extends StatefulWidget {
  final List<Post> posts;
  final User user;

  const PostsTab({
    Key key,
    @required this.posts,
    @required this.user,
  }) : super(key: key);
  @override
  _PostsTabState createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  List<Post> posts;
  @override
  void initState() {
    posts = widget.posts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          var post = posts[index];
          post.user = widget.user;
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
              left: 2,
              right: 2,
            ),
            child: PostTileAlt(
              post: post,
              showShare: true,
              showComments: true,
              canTapUserProfile: false,
            ),
          ).fadeInList(index, true);
        },
      ),
    );
  }
}
