import 'package:buddy/models/post.dart';
import 'package:buddy/models/user.dart';
import 'package:buddy/views/tabs/profile/tabs/posts.tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

class PostTabBuilder extends StatefulWidget {
  final User user;

  const PostTabBuilder({Key key, this.user}) : super(key: key);
  @override
  _PostTabBuilderState createState() => _PostTabBuilderState();
}

class _PostTabBuilderState extends State<PostTabBuilder> {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("posts");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    auth.User currentUser = Provider.of<auth.User>(context);
    Future<List<Post>> userPosts() async {
      List postIds = widget.user.posts;
      List<Post> posts = [];
      for (int i = 0; i < postIds.length; i++) {
        var postDoc = await collectionRef.doc(postIds[i]).get();
        posts.add(
            Post.fromMap(data: postDoc.data(), currentUserId: currentUser.uid));
      }
      return posts;
    }

    return FutureBuilder(
        future: userPosts(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Text("Waiting..."),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return PostsTab(posts: snapshot.data, user: widget.user);
            default:
              return null;
          }
        });
  }
}
