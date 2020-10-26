import 'user.dart';

class Comment {
  User user;
  int date;
  String content;

  Comment({this.user, this.date, this.content});

  factory Comment.fromMap(Map data) {
    return Comment(
      content: data["content"],
      user: User.fromMap(data),
      date: data["date"],
    );
  }
}
