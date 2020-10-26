import 'dart:io';

import '../../global_widgets/circular_image.dart';

import '../../models/user.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final User user;

  const StoryViewPage({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final storyController = StoryController();
  List<StoryItem> stories = [];

  @override
  void initState() {
    stories = [
      StoryItem.text(
        title:
            "Did you know the earth was flat until God provided an update? 😂😂😂",
        backgroundColor: Colors.purple,
      ),
      StoryItem.text(
        title: "Today has been an awesome one, thanks to my lovely friends ❤️",
        backgroundColor: Colors.red,
      ),
      StoryItem.pageImage(
        caption: "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥",
        controller: storyController,
        url:
            "https://i.pinimg.com/originals/f6/eb/53/f6eb535411056b553dfdec1665387c0c.jpg",
      ),
      StoryItem.pageImage(
        caption: "Simply beautiful😘😘😘",
        controller: storyController,
        url:
            "http://s3.weddbook.com/t4/2/5/0/2501568/vanila-wedding-boutique-dubai-on-instagram-have-a-lovely-weekend-everyone-let-it-be-sunny-throughout-the-upcoming-days-to-enjoy-the-beach-and-the-sea-our-lovely-vanila-bride.jpg",
      ),
      StoryItem.pageImage(
        url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
        caption: "Thanks for watching",
        controller: storyController,
      ),
    ];

    stories.shuffle();
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Container(
      padding: EdgeInsets.only(
        top: Platform.isIOS ? 68 : 48,
        left: 16,
        right: 16,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          // width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: 10.0),
              CircularImage(image: widget.user.photo),
            ],
          ),
        ),
        title: Text(
          widget.user.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "3 hours ago",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      body: Dismissible(
        background: Container(
          color: Colors.black,
        ),
        direction: DismissDirection.vertical,
        key: Key('key'),
        onDismissed: (_) => Navigator.of(context).pop(),
        child: Stack(
          children: <Widget>[
            StoryView(
              controller: storyController,
              storyItems: stories,
              onComplete: () {
                Navigator.pop(context);
              },
            ),
            userInfo
          ],
        ),
      ),
    );
  }
}
