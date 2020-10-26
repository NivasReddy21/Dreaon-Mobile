import 'package:buddy/models/user.dart' as ModelUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProviver {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getUserById(String userID) async {
    DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(userID).get();
    ModelUser.User user = ModelUser.User.fromMap(userDoc.data());
    return user;
  }

  Future addComment({String content, User user, String postId}) async {
    var data = {
      "content": content,
      "userName": user.displayName,
      "profile_url": user.photoURL,
      "uid": user.uid,
      "date": DateTime.now().day
    };

    _firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc()
        .set(data);
    _firestore.collection("posts").doc(postId).update({
      "Comments": FieldValue.increment(1),
    });
  }

  Future like(String userId, String postId) async {
    DocumentSnapshot document =
        await _firestore.collection("posts").doc(postId).get();
    if (document.data()['likedUsers'].contains(userId)) {
      _firestore.collection("posts").doc(postId).update({
        'likedUsers': FieldValue.arrayRemove([userId])
      });
      _firestore
          .collection("posts")
          .doc(postId)
          .update({'Likes': FieldValue.increment(-1)});
    } else {
      _firestore.collection("posts").doc(postId).update({
        'likedUsers': FieldValue.arrayUnion([userId])
      });
      _firestore
          .collection("posts")
          .doc(postId)
          .update({'Likes': FieldValue.increment(1)});
    }
  }

  Future follow(String currentUserId, String followUserId) async {
    var followingMap = Map<String, String>();
    followingMap['uid'] = followUserId;
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followUserId)
        .set(followingMap);
    var followerMap = Map<String, String>();
    followerMap['uid'] = currentUserId;
    await _firestore
        .collection("users")
        .doc(followUserId)
        .collection("followers")
        .doc(currentUserId)
        .set(followerMap);
  }

  Future unfollow(String currentUserId, String followUserId) async {
    var followingMap = Map<String, String>();
    followingMap['uid'] = followUserId;
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followUserId)
        .delete();
    var followerMap = Map<String, String>();
    followerMap['uid'] = currentUserId;
    await _firestore
        .collection("users")
        .doc(followUserId)
        .collection("followers")
        .doc(currentUserId)
        .delete();
  }

  Future<bool> checkIsFollowing(
      String currentUserId, String otherUserId) async {
    bool isFollowing = false;
    DocumentSnapshot snapshot = await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(otherUserId)
        .get();
    if (snapshot.data() != null) {
      print(snapshot.data());
      isFollowing = true;
    }
    return isFollowing;
  }

  Future<List<DocumentSnapshot>> fetchStats({String uid, String label}) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").doc(uid).collection(label).get();
    return querySnapshot.docs;
  }
}
