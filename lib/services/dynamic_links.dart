import 'package:buddy/constants/routes.dart';
import 'package:buddy/models/post.dart';
import 'package:buddy/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future handleDynamicLinks(BuildContext context) async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data, context);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDeepLink(dynamicLinkData, context);
    }, onError: (OnLinkErrorException e) async {
      print("Link Failed ${e.message}");
    });
  }

  void _handleDeepLink(
      PendingDynamicLinkData data, BuildContext context) async {
    Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);

      var isPost = deepLink.pathSegments.contains('post');
      if (isPost) {
        var postId = deepLink.queryParameters['id'];
        print(postId);
        var doc = await FirebaseFirestore.instance
            .collection("posts")
            .doc(postId)
            .get();
        Post post = Post(
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
          isLiked: doc.data()['likedUsers'].contains(doc.data()["userId"]),
        );
        Navigator.pushNamed(
          context,
          AppRoutes.postDetails,
          arguments: post,
        );
        deepLink = null;
      }
    }
  }

  Future<String> postLink(Post post) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://dreaon.com',
      link: Uri.parse(
        'http://www.dreaon.com/post?id=${post.postId}',
      ),
      androidParameters: AndroidParameters(
        packageName: 'com.example.buddy',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        description: post.content,
        imageUrl: Uri.parse(post.photo),
      ),
    );

    // final Uri dynamicurL = await parameters.buildUrl();
    final ShortDynamicLink url = await parameters.buildShortLink();
    return url.shortUrl.toString();
  }
}
