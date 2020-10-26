import 'user.dart';

class LiveTv {
  final User user;
  final String video;
  final String videoThumb;
  final String videoTitle;
  final int comments;
  final int views;
  final bool isVerified;

  LiveTv({
    this.user,
    this.video = "https://firebasestorage.googleapis.com/v0/b/fluttermarket-file-upload.appspot.com/o/Time%20Lapse%20Video%20Of%20Milky%20Way%20Galaxy_3.mp4?alt=media&token=796c38fe-5c39-4050-86ac-3845e39c2489",
    this.videoThumb,
    this.videoTitle,
    this.comments,
    this.views,
    this.isVerified,
  });
}
