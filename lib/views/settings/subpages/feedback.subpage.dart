import '../../../views/settings/widgets/emoji_selector.dart';
import 'package:flutter/material.dart';

class FeedbackSubpage extends StatefulWidget {
  final String title;
  final String content;

  const FeedbackSubpage({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);
  @override
  _FeedbackSubpageState createState() => _FeedbackSubpageState();
}

class _FeedbackSubpageState extends State<FeedbackSubpage> {
  bool showThanks = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(widget.content),
          Divider(
            height: 36.0,
          ),
          _buildReaction(),
        ],
      ),
    );
  }

  Widget _buildReaction() {
    final emojiSelector = Visibility(
      visible: !showThanks,
      child: Container(
        child: EmojiSelector(
          onTap: (String value) {
            setState(() {
              showThanks = true;
            });
          },
        ),
      ),
    );

    final thankYouNote = Visibility(
      visible: showThanks,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.1)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Thank you for your feedback")
          ],
        ),
      ),
    );

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !showThanks,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text("Is your problem resolved?"),
            ),
          ),
          emojiSelector,
          thankYouNote,
        ],
      ),
    );
  }
}
