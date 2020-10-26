import '../models/live_tv.dart';

import '../models/comment.dart';

import '../models/post.dart';

import '../models/notification.dart';

import '../models/message.dart';
import '../models/message_details.dart';
import '../models/user.dart';

import 'images.dart';

class AppData {
  static List<User> users = [
    User(
      name: "Emmanuel Fache",
      username: "emrade",
      photo: AppImages.user0,
      followers: 89627272,
      following: 0,
      likes: 2387733,
    ),
    User(
      name: "Caroline Forbs",
      username: "karo",
      photo: AppImages.woman1,
      followers: 26628,
      following: 2772,
      likes: 3663,
      isFollowing: true,
    ),
    User(
      name: "Sue Caldwel",
      username: "sue",
      photo: AppImages.woman2,
      followers: 26628,
      following: 2772,
      likes: 3663,
    ),
    User(
      name: "Alicia Monroe",
      username: "ally",
      photo: AppImages.woman3,
      followers: 26628,
      following: 2772,
      likes: 3663,
      isFollowing: true,
    ),
    User(
      name: "Adnan Heyes",
      username: "adnan",
      photo: AppImages.man1,
      followers: 26628,
      following: 2772,
      likes: 3663,
    ),
    User(
      name: "Christopher Jenkins",
      username: "chris",
      photo: AppImages.man2,
      followers: 26628,
      following: 2772,
      likes: 3663,
      isFollowing: true,
    ),
    User(
      name: "Danielle Rosa",
      username: "dani",
      photo: AppImages.woman,
      followers: 26628,
      following: 2772,
      likes: 3663,
    ),
    User(
      name: "Mich Justin",
      username: "mich",
      photo: AppImages.man3,
      followers: 26628,
      following: 2772,
      likes: 3663,
      isFollowing: true,
    ),
    User(
      name: "Laura H.",
      username: "laura",
      photo: AppImages.woman4,
      followers: 26628,
      following: 2772,
      likes: 3663,
    ),
    User(
      name: "Kelly R.",
      username: "kelly",
      photo: AppImages.woman5,
      followers: 26628,
      following: 2772,
      likes: 3663,
      isFollowing: true,
    ),
  ];

  static List<Message> messages = [
    Message(
      user: users[5],
      time: "9:20 AM",
      unread: 5,
      content: "Hey! How's it going? 😅.",
    ),
    Message(
      user: users[1],
      time: "8:10 AM",
      unread: 0,
      content: "What kind of music do you like?",
    ),
    Message(
      user: users[2],
      time: "Yesterday",
      unread: 1,
      content: "Sounds good to me",
    ),
    Message(
      user: users[3],
      time: "2d ago",
      unread: 0,
      content: "I see you had a good night 😉",
    ),
    Message(
      user: users[4],
      time: "3d ago",
      unread: 2,
      content: "What did you do over the weekend?",
    ),
  ];

  static List<MessageDetails> messageDetails = [
    MessageDetails(
      content: "Hey there, how are you doing?",
      isFromMe: true,
      date: "Tuesday 9:20 AM",
    ),
    MessageDetails(
      content: "Just fine. I was about to call you, i miss you.",
      isFromMe: false,
      date: "Tuesday 10:00 AM",
    ),
    MessageDetails(
      content: "oh yeah? ",
      isFromMe: true,
      date: "Wednesday 12:13 PM",
    ),
  ];

  static List<AppNotification> notifications = [
    AppNotification(user: users[8], action: "followed you", isFollow: true),
    AppNotification(
      user: users[6],
      action: "liked your photo",
      isLike: true,
      photos: [AppImages.landingBanner5],
    ),
    AppNotification(
      user: users[1],
      comment: "❤️",
      isReaction: true,
    ),
    AppNotification(
      user: users[3],
      comment: "The party was amazing, let's hang out more. Cheers! 🥂",
      isComment: true,
      photos: [AppImages.landingBanner3],
    ),
    AppNotification(
      user: users[2],
      isAddPhotos: true,
      photos: [
        AppImages.man1,
        AppImages.woman,
        AppImages.woman1,
        AppImages.woman2,
        AppImages.woman3,
      ],
    ),
  ];

  List<Post> posts = [
    Post(
        photo: AppImages.landingBanner5,
        tags: ["relax", "travel"],
        likesCount: 364,
        commentsCount: 34,
        sharesCount: 246,
        content:
            "Music can be as powerful a motivator as motivational quotes. Each morning when you wake up, play a few pump up songs before you start your day to get you going. You can listen to playlists with motivational songs on Spotify to help you get going. By getting your mind in the right mindset, you can inch closer to motivating yourself. "),
    Post(
      photo: AppImages.landingBanner3,
      tags: ["love", "hope"],
      likesCount: 2038,
      commentsCount: 1273,
      sharesCount: 688,
      content:
          """This goes back to the positive environment point: You need to be around with others who are just ambitious as you. American entrepreneur John Rohn once said, “You’re the average of the five people you spend the most time with it.” And whether or not that’s true is debatable, the reality is being around the right kind of people can only help you grow. If you’re surrounded by those who love your ambition, you’ll be more ambitious and achieve more.""",
    ),
    Post(
      photo: AppImages.landingBanner,
      tags: ["anime", "movie"],
      likesCount: 7299,
      commentsCount: 2767,
      sharesCount: 4526,
      content:
          "How wonderful it is that nobody need wait a single moment before starting to improve the world.",
    ),
  ];

  List<Post> postsNoPhotos = [
    Post(
      tags: ["movie", "film"],
      likesCount: 35,
      commentsCount: 45673,
      sharesCount: 3773,
      content: "I'm about as intimidating as a butterfly",
    ),
    Post(
        tags: ["trailer", "ui"],
        likesCount: 3663,
        commentsCount: 34,
        sharesCount: 333,
        content:
            "The lampshade on my head is for my bright ideas. I won't be able to convey them until Monday, when my curtain gets out of the dry cleaners"),
    Post(
      tags: ["ux", "ui"],
      likesCount: 7299,
      commentsCount: 2767,
      sharesCount: 4526,
      content:
          "All of my best friends are dead people. Someday I've got to figure out how that happened.",
    ),
    Post(
      tags: ["motivation"],
      likesCount: 9763,
      commentsCount: 2767,
      sharesCount: 4526,
      content: "Act first, explain later.",
    ),
    Post(
      tags: ["motivation"],
      likesCount: 4112,
      commentsCount: 752,
      sharesCount: 4526,
      content: "What's my age again",
    ),
  ];

  static List<Comment> comments = [
    Comment(
      user: users[3],
      date: 5,
      content:
          "I get the biggest enjoyment from the random and unexpected places.",
    ),
    Comment(
      user: users[1],
      date: 5,
      content:
          "In real open source, you have the right to control your own destiny",
    ),
    Comment(
      user: users[5],
      date: 5,
      content:
          "Now this is not the end. It is not even the beginning of the end. But it is, perhaps, the end of the beginning",
    ),
    Comment(
      user: users[0],
      date: 5,
      content:
          "He who learns but does not think, is lost! He who thinks but does not learn is in great danger.",
    ),
    Comment(
      user: users[2],
      date: 5,
      content:
          "I never learn anything talking. I only learn things when I ask questions",
    ),
  ];

  List<LiveTv> liveTvs = [
    LiveTv(
      user: users[5],
      videoThumb: "https://i.ytimg.com/vi/39qM789Zw2A/maxresdefault.jpg",
      videoTitle: "Movies Everyone Should See At Least Once In Their Life",
      comments: 64,
      views: 4239,
    ),
    LiveTv(
      user: users[2],
      videoThumb: "https://i.ytimg.com/vi/AC2r3ZgYOWs/maxresdefault.jpg",
      videoTitle: "Frozen - Let It Go ( cover by J.Fla )",
      comments: 9309,
      views: 24904949,
    ),
    LiveTv(
      user: users[4],
      videoThumb: "https://i.ytimg.com/vi/rrARCeurxTw/maxresdefault.jpg",
      videoTitle: "NEW MOVIE TRAILERS",
      comments: 63,
      views: 20083,
    ),
    LiveTv(
      user: users[5],
      videoThumb: "https://i.ytimg.com/vi/nF4hg6g7SwE/maxresdefault.jpg",
      videoTitle: "Dope Tech: The Biggest Ultrawide Monitor!",
      comments: 39903,
      views: 763377,
    ),
    LiveTv(
      user: users[3],
      videoThumb: "https://i.ytimg.com/vi/k-42IZWfZ-Q/maxresdefault.jpg",
      videoTitle: "THE OLD GUARD Ending Explained!",
      comments: 873,
      views: 12368,
    ),
    LiveTv(
      user: users[1],
      videoThumb: "https://i.ytimg.com/vi/nfM1w8PLE-c/maxresdefault.jpg",
      videoTitle: "M249 vs 4 RUSHER in Last Zone | PUBG MOBILE",
      comments: 2786,
      views: 9873,
    ),
  ];
}
