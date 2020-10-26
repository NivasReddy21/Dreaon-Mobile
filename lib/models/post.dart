import 'user.dart';

class Post {
  User user;
  String postId;
  String photo;
  String content;
  bool isLiked;
  int likesCount, commentsCount, sharesCount;
  List<String> tags;
  Post({
    this.postId,
    this.user,
    this.photo,
    this.content,
    this.likesCount,
    this.commentsCount,
    this.sharesCount,
    this.tags,
    this.isLiked,
  });
  factory Post.fromMap({Map data, String currentUserId}) {
    return Post(
      user: User(
        id: data["uid"],
        username: data["userName"],
        name: data["userName"],
      ),
      content: data['details'],
      likesCount: data['Likes'],
      commentsCount: data['Comments'],
      sharesCount: data['Shares'],
      photo: data['imageUrl'],
      tags: [data['tag1'], data['tag2']],
      isLiked: data['likedUsers'].contains(currentUserId),
    );
  }
}
