import 'package:buddy/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/post_tile.dart';
import '../../../config/extensions.dart';

import '../../../constants/routes.dart';
import '../../../global_widgets/custom_form_field_alt.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../models/post.dart';

import '../../../global_widgets/gradient_icon_button.dart';
import '../../../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final FocusNode inputFocusNode = FocusNode();

  FirebaseProviver firebaseProviver = new FirebaseProviver();

  @override
  Widget build(BuildContext context) {
    auth.User user = Provider.of<auth.User>(context);
    final camBtn = Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: GradientIconButton(
        icon: FlutterIcons.edit_3_fea,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.createPost,
          );
        },
      ),
    );

    final topBar = Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomFormFieldAlt(
              focusNode: inputFocusNode,
              hintText: "Search",
              readOnly: true,
              icon: LineAwesomeIcons.search,
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  AppRoutes.search,
                );

                inputFocusNode.unfocus();
              },
              bottomPadding: 0,
            ),
          ),
          camBtn
        ],
      ),
    );
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy("time")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Post> posts = docs
              .map((doc) => Post(
                    user: User(
                      name: doc.data()['userName'],
                      username: doc.data()['userName'],
                      id: doc.data()['userId'],
                      photo: doc.data()['userPhoto'],
                      followers: 100,
                      following: 100,
                      likes: 100,
                    ),
                    content: doc.data()['details'],
                    likesCount: doc.data()['Likes'],
                    commentsCount: doc.data()['Comments'],
                    sharesCount: doc.data()['Shares'],
                    photo: doc.data()['imageUrl'],
                    postId: doc.id,
                    tags: [doc.data()['tag1'], doc.data()['tag2']],
                    isLiked: doc.data()['likedUsers'].contains(user.uid),
                  ))
              .toList();

          print(posts[0]);

          return Container(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      topBar,
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (
                    BuildContext context,
                    int index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: PostTile(
                        post: posts[index],
                      ).fadeInList(index, true),
                    );
                  },
                  childCount: posts.length,
                ))
              ]));
        }
      },
    );
  }
}
