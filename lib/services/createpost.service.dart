import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePost {
  Future<void> createPost(
      {File file,
      String details,
      String userName,
      String userPhoto,
      String tag1,
      String tag2,
      String userId}) async {
    var storage = FirebaseStorage.instance;
    String postId = userName + DateTime.now().millisecondsSinceEpoch.toString();
    StorageTaskSnapshot snapshot =
        await storage.ref().child("posts/$postId").putFile(file).onComplete;

    if (snapshot.error == null) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      var postData = {
        "userName": userName,
        "userId": userId,
        "userPhoto": userPhoto,
        "postId": postId,
        "imageUrl": downloadUrl,
        "details": details,
        "Likes": 0,
        "Comments": 0,
        "Shares": 0,
        "tag1": tag1,
        "tag2": tag2,
        "time": -1 * DateTime.now().millisecondsSinceEpoch,
        "likedUsers": []
      };

      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .set(postData);
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "posts": FieldValue.arrayUnion([postId])
      });
    } else {
      print('Error from image repo ${snapshot.error.toString()}');
      throw ('This file is not an image');
    }
  }
}
