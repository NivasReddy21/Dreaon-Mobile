import '../../../../constants/constants.dart';
import '../../../../constants/routes.dart';
import '../../../../utils/utils.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../../models/user.dart';
import '../../../../config/extensions.dart';
import 'package:flutter/material.dart';
import '../../../../global_widgets/circular_image.dart';

class StoryTile extends StatelessWidget {
  final User user;

  const StoryTile({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<bool> status = [false, true, true];
    status.shuffle();
    bool currentStatus = status[0];

    final userImage = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 65.0,
          width: 65.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppConstants.gradient,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CircularImage(image: user.photo),
        ),
        Visibility(
          visible: currentStatus,
          child: Positioned(
            bottom: 0.0,
            child: Container(
              height: 24.0,
              width: 50.0,
              decoration: BoxDecoration(
                gradient: AppConstants.gradient,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.video_camera,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  Utils.horizontalSpacer(space: 5),
                  Text(
                    "Live",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

    final firstName = Text(
      user.name.firstName,
      style: Theme.of(context).textTheme.bodyText1,
    );

    return MaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutes.storyView,
        arguments: user,
      ),
      child: Container(
        child: Column(
          children: [
            userImage,
            firstName,
          ],
        ),
      ),
    );
  }
}
