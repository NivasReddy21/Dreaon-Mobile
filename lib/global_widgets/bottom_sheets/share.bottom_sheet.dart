import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/utils.dart';
import '../../global_widgets/icon_btn.dart';

import '../../constants/data.dart';
import '../../models/user.dart';
import 'package:flutter/material.dart';

import '../circular_image.dart';
import '../../config/extensions.dart';

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      AppData.users[9],
      AppData.users[8],
      AppData.users[7],
    ];

    final control = Container(
      height: 5.0,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );

    final sendTo = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
      child: Text(
        "Send to",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    final userList = Container(
      height: 90.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(children: [
              CircularImage(image: users[index].photo),
              Utils.verticalSpacer(space: 5),
              Text(
                users[index].name.firstName,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              )
            ]),
          );
        },
      ),
    );

    final shareSection = Container(
      padding: EdgeInsets.all(15.0),
      width: double.infinity,
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: <Widget>[control, sendTo, userList],
      ),
    );

    final shareTo = Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Text(
        "Share to",
        style: TextStyle(
         color: Theme.of(context).textTheme.bodyText1.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    final socialList = Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconBtn(
            icon: FlutterIcons.whatsapp_mco,
            color: Color(0xFF25D366),
            name: "WhatsApp",
          ),
          IconBtn(
            icon: FlutterIcons.paper_plane_ent,
            color: Colors.red,
            name: "Message",
          ),
          IconBtn(
            icon: FlutterIcons.comment_outline_mco,
            color: Colors.green,
            name: "SMS",
          ),
          IconBtn(
            icon: FlutterIcons.facebook_messenger_mco,
            color: Color(0xFF00B2FF),
            name: "Messenger",
          ),
          IconBtn(
            icon: FlutterIcons.link_fea,
            color: Colors.blue,
            name: "Copy link",
          ),
          IconBtn(
            icon: FlutterIcons.facebook_fea,
            color: Color(0xFF4267B2),
            name: "Facebook",
          ),
          IconBtn(
            icon: FlutterIcons.twitter_fea,
            color: Color(0xFF1DA1F2),
            name: "Twitter",
          ),
          IconBtn(
            icon: FlutterIcons.mail_fea,
            color: Colors.lightBlue.withOpacity(0.5),
            name: "Email",
          ),
          IconBtn(
            icon: FlutterIcons.more_horizontal_fea,
            color: Colors.blue.withOpacity(0.5),
            name: "Other",
          ),
        ],
      ),
    );

    final sendSection = Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [shareTo, socialList],
      ),
    );

    final cancel = Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1.0,
          color: Colors.grey.withOpacity(0.5),
        ),
      )),
      width: double.infinity,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text("Cancel"),
          ),
        ),
      ),
    );

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[shareSection, sendSection, cancel],
      ),
    );
  }
}
