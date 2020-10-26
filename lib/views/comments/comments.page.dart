import 'dart:io';

import 'package:buddy/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

import '../../utils/theme_utils.dart';
import '../../global_widgets/custom_form_field_alt.dart';

import '../../global_widgets/header_text.dart';
import '../../views/comments/widgets/comment_tile.dart';

// import '../../constants/data.dart';
import '../../models/comment.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  const CommentsPage({Key key, @required this.postId}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  // List<Comment> comments = AppData.comments;

  TextEditingController content = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  addMessage({User user, String postId}) async {
    if (content.text != "") {
      await FirebaseProviver()
          .addComment(user: user, content: content.text, postId: postId);
      setState(() {
        content.text = "";
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
    var user = Provider.of<User>(context);
    final header = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: HeaderText(text: "Comments"),
    );

    Widget list(List<Comment> comments) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 20.0),
            controller: _scrollController,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              return CommentTile(
                comment: comments[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1,
              );
            },
          ),
        ),
      );
    }

    final bottom = Container(
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
        controller: content,
        hintText: "Write a comment",
        bottomPadding: 0,
        prefixIcon: Icon(FlutterIcons.edit_3_fea),
        suffixIcon: IconButton(
          onPressed: () => addMessage(user: user, postId: widget.postId),
          icon: Icon(
            LineAwesomeIcons.paper_plane,
            color: Theme.of(context).primaryColor,
            size: 26,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .doc(widget.postId)
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, list(comments), bottom],
              );
            }),
      ),
    );
  }
}
