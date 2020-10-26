import 'package:buddy/models/user.dart' as UserModel;
import 'package:buddy/services/db.dart';
import 'package:buddy/views/tabs/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileBuilder extends StatefulWidget {
  final String userId;

  const ProfileBuilder({Key key, this.userId}) : super(key: key);
  @override
  _ProfileBuilderState createState() => _ProfileBuilderState();
}

class _ProfileBuilderState extends State<ProfileBuilder> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var currentUserId = FirebaseAuth.instance.currentUser.uid;
  bool isMyProfile = false;
  bool isFollowing = false;
  void checkFollow() async {
    bool follow =
        await FirebaseProviver().checkIsFollowing(currentUserId, widget.userId);
    setState(() {
      isFollowing = follow;
    });
  }

  @override
  void initState() {
    if (widget.userId == currentUserId) {
      setState(() {
        isMyProfile = true;
      });
    }

    if (!isMyProfile) {
      checkFollow();
      print(isFollowing);
    }
    print(isFollowing);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firestore.collection('users').doc(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot doc) {
          if (doc.connectionState == ConnectionState.done) {
            if (doc.hasData) {
              var user = UserModel.User.fromMap(doc.data.data());
              print(isFollowing);
              return ProfileTab(
                userDetails: user,
                isMyProfile: isMyProfile,
                isFollowing: isFollowing,
              );
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
