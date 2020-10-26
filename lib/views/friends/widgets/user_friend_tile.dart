import '../../../constants/routes.dart';

import '../../../global_widgets/circular_image.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/outline_gradient_button.dart';

import '../../../models/user.dart';
import 'package:flutter/material.dart';

class UserFriendTile extends StatefulWidget {
  final User user;

  const UserFriendTile({Key key, this.user}) : super(key: key);

  @override
  _UserFriendTileState createState() => _UserFriendTileState();
}

class _UserFriendTileState extends State<UserFriendTile> {
  List<bool> following = [true, false];
  bool currentFollowing;

  List<int> count = [4, 5, 6, 7, 8, 9];
  int currentCount;

  void follow(bool follow) {
    setState(() {
      currentFollowing = follow;
    });
  }

  @override
  void initState() {
    super.initState();
    following.shuffle();

    count.shuffle();
    currentCount = count[0];
    currentFollowing = following[0];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.profile,
        arguments: widget.user.id,
      ),
      contentPadding: EdgeInsets.zero,
      leading: CircularImage(image: widget.user.photo),
      title: Text(widget.user.name),
      subtitle: Text("$currentCount mutual friends"),
      trailing: !currentFollowing
          ? SizedBox(
              width: 100.0,
              height: 35.0,
              child: CustomButton(
                wrap: true,
                onPressed: () => follow(true),
                text: "Follow",
              ),
            )
          : OutlineGradientButton(
              text: "Unfollow",
              onPressed: () => follow(false),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
    );
  }
}
