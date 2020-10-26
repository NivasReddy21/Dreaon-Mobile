import 'user.dart';

class AppNotification {
  User user;
  String action;
  List<String> photos;
  String comment;
  bool isFollow;
  bool isLike;
  bool isReaction;
  bool isComment;
  bool isAddPhotos;

  AppNotification({
    this.user,
    this.action,
    this.photos,
    this.comment,
    this.isFollow = false,
    this.isLike = false,
    this.isReaction = false,
    this.isComment = false,
    this.isAddPhotos = false,
  });
}
