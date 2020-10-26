import '../../utils/theme_utils.dart';

import '../../constants/images.dart';
import '../../constants/routes.dart';
import '../../utils/utils.dart';
import '../../global_widgets/header_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationTogglePage extends StatefulWidget {
  @override
  _NotificationTogglePageState createState() => _NotificationTogglePageState();
}

class _NotificationTogglePageState extends State<NotificationTogglePage> {
  bool allowNotifications = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDarkMode = ThemeUtils.isDarkMode(context);
    Color color = isDarkMode ? Colors.black : Theme.of(context).primaryColor;

    final image = Container(
      height: screenHeight * 0.25,
      alignment: Alignment.center,
      child: Lottie.asset(
        AppAnim.bell,
      ),
    );

    final inner = Container(
      margin: EdgeInsets.only(top: 40.0),
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: image,
      ),
    );

    final outter = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40.0),
          height: screenHeight * 0.3,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: inner,
        )
      ],
    );

    final title = HeaderText(
      text: "Turn on \nNotifications",
      fontSize: 35.0,
      textAlign: TextAlign.center,
    );

    final subtitle = HeaderText(
      text:
          "Enable push notifications so we can send you personal news and updates.",
      isBig: false,
      textAlign: TextAlign.center,
    );

    final toggleCard = Container(
      padding: EdgeInsets.all(20.0),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Turn on notifications",
            style: TextStyle(color: Colors.black87, fontSize: 16.0),
          ),
          CupertinoSwitch(
            activeColor: Theme.of(context).primaryColor,
            value: allowNotifications,
            onChanged: (bool value) {
              setState(() {
                allowNotifications = value;
              });
            },
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.inviteFriends);
              },
              child: Text(
                "NEXT",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            outter,
            Utils.verticalSpacer(space: 40.0),
            title,
            Utils.verticalSpacer(space: 5.0),
            subtitle,
            Utils.verticalSpacer(space: 40.0),
            toggleCard
          ],
        ),
      ),
    );
  }
}
