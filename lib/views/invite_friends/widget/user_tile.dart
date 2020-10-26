import '../../../global_widgets/gradient_toggle.dart';

import '../../../global_widgets/circular_image.dart';

import '../../../models/user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  final User user;

  const UserTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  List<bool> status = [false, true];
  bool currentStatus;

  List<String> friendsOn = ['Facebook', 'Twitter', 'Instagram'];
  String currentFriendsOn;
  @override
  void initState() {
    status.shuffle();
    friendsOn.shuffle();
    currentStatus = status[0];
    currentFriendsOn = friendsOn[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(image: widget.user.photo),
      contentPadding: EdgeInsets.zero,
      title: Text(widget.user.name),
      subtitle: Text("You're friends on $currentFriendsOn"),
      trailing: GradientToggle(
        value: currentStatus,
        onChanged: () {
          setState(() {
            currentStatus = !currentStatus;
          });
        },
      ),
    );
  }
}
