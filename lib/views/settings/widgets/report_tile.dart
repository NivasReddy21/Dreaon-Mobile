import '../subpages/feedback.subpage.dart';

import '../../../constants/routes.dart';
import '../../../models/settings_base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportTile extends StatefulWidget {
  final String title;
  final String content;

  const ReportTile({
    Key key,
    @required this.title,
    this.content =
        """It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.""",
  }) : super(key: key);

  @override
  _ReportTileState createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  bool showThanks = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 14.0),
      ),
      trailing: Icon(CupertinoIcons.right_chevron),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.settingsBase,
          arguments: SettingsBaseView(
            title: "Feedback and help",
            body: FeedbackSubpage(
              title: widget.title,
              content: widget.content,
            ),
          ),
        );
      },
    );
  }
}
