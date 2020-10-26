import 'user.dart';

class Message {
  User user;
  int unread;
  String time, content;
  Message({
    this.user,
    this.time,
    this.unread,
    this.content,
  });
}
